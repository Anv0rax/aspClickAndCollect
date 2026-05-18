using ClickCollect_Antoine_Nolan_2026.DAL;
using ClickCollect_Antoine_Nolan_2026.Models;
using ClickCollect_Antoine_Nolan_2026.ViewModel;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System.Text.Json;
using System.Threading.Tasks;

namespace ClickCollect_Antoine_Nolan_2026.Controllers
{
    public class CartController : BaseController
    {
        private readonly IProductDAL productDAL;
        private readonly IShopDAL shopDAL;
        private readonly IUserDAL userDAL;
        private readonly IOrderDAL orderDAL;

        public CartController(IProductDAL productDAL, IShopDAL shopDAL, IUserDAL userDAL, IOrderDAL orderDAL)
        {
            this.productDAL = productDAL;
            this.shopDAL = shopDAL;
            this.userDAL = userDAL;
            this.orderDAL = orderDAL;
        }

        // Since we are stocking the shopping cart in a session, we
        // have to retrives the shopping cart list, from the session.

        private List<ProductQuantity> GetCartFromSession()
        {
            string? cartJson = HttpContext.Session.GetString("Cart");

            if (string.IsNullOrEmpty(cartJson))
            {
                return new List<ProductQuantity>();
            }

            return JsonSerializer.Deserialize<List<ProductQuantity>>(cartJson) ?? new List<ProductQuantity>();
        }

        // After this, i need to save the cart TO the session.
        private void SaveCartToSession(List<ProductQuantity> cart)
        {
            HttpContext.Session.SetString("Cart", JsonSerializer.Serialize(cart));
        }

        // Now im going to add the method to add a product to the cart
        // For that, I will check if the customer is authentificated, then i take the product out off the database.
        // If its aleardy in the cart, i will increase the quantity.
        // When its done, I will call SaveCartToSession method.

        [HttpPost]
        public async Task<IActionResult> AddToCart(int productId, int quantity)
        {
            if (HttpContext.Session.GetInt32("UserId") == null)
                return RedirectToAction("Login", "User");

            if (quantity < 1 || quantity > 100)
            {
                TempData["Error"] = "Please choose between 1 and 100 products.";
                return RedirectToAction("ViewProduct", "Product", new { id = productId });
            }

            Product? pt = await Product.GetProductByIdAsync(productDAL, productId);

            if(pt == null)
            {
                TempData["Error"] = "Sorry, the product has not been found. Please try later.";
                return RedirectToAction("Index", "Home");
            }

            List<ProductQuantity> cart = GetCartFromSession();

            ProductQuantity? productAlreadyCart = cart.FirstOrDefault(p => p.GetProductID() == productId);

            if (productAlreadyCart != null)
                productAlreadyCart.Quantity += quantity;
            else
                cart.Add(new ProductQuantity(pt, quantity));

            SaveCartToSession(cart);

            TempData["Success"] = "The product has been saved to your shopping list !";
            return RedirectToAction("Index", "Home");
        }

        [HttpPost]
        public IActionResult RemoveFromCart(int productId)
        {
            List<ProductQuantity> cart = GetCartFromSession();
            cart.RemoveAll(p => p.GetProductID() == productId);
            SaveCartToSession(cart);
            return RedirectToAction("Index");
        }

        [HttpPost]
        public async Task<IActionResult> UpdateCart(List<ProductQuantity> cart, string action)
        {
            List<ProductQuantity> validCart = new List<ProductQuantity>();
            bool errorInCart;

            if (!(action == "save" || action == "confirm"))
            { 
                int prodId;

                if(int.TryParse(action, out prodId))
                    cart.RemoveAll(p => p.GetProductID() == prodId);
            }

            SaveCartToSession(cart);

            (validCart, errorInCart) = await GetValidatedCartAsync();
            if (errorInCart)
                TempData["Error"] = "WARNING : A product not found was in your list. This product is then removed from your shopping list.";

            SaveCartToSession(validCart);

            if (action == "confirm")
            {
                return RedirectToAction("SelectShop");
            }
            return RedirectToAction("Index");
        }

        public async Task<IActionResult> SelectShop()
        {
            int? userId = HttpContext.Session.GetInt32("UserId");
            if (userId == null)
                return RedirectToAction("Login", "User");

            List<Shop>? shops = await Shop.GetShopsAsync(shopDAL);
            if (shops == null)
            {
                TempData["Error"] = "Error with shop selection";
                return RedirectToAction("Index", "Home");
            }

            TempData["Distances"] = null;

            Customer? thisUser = await Models.User.GetCustomerByIdAsync(userDAL, (int)userId);
            if (thisUser == null)
                return RedirectToAction("Login", "User");

            if(thisUser.Adress != null)
            {
                double userLon = thisUser.Adress.Longitude;
                double userLat = thisUser.Adress.Latitude;
                if (userLon != -1 && userLat != -1)
                {
                    List<double> distances = new List<double>();
                    for (int i = 0; i < shops.Count; i++)
                    {
                        distances.Add(shops[i].Adress!.GetDistanceWith(userLon, userLat));
                    }
                    TempData["Distances"] = System.Text.Json.JsonSerializer.Serialize(distances);
                }

            }

            return View(shops);
        }

        [HttpPost]
        [HttpGet]
        public async Task<IActionResult> Confirm(int shopId)
        {
            int? userId = HttpContext.Session.GetInt32("UserId");
            if (userId == null)
                return RedirectToAction("Login", "User");

            ConfirmCartViewModel vm = new ConfirmCartViewModel();
            vm.Cart = GetCartFromSession();
            List<Shop>? shops = await Shop.GetShopsAndTimeslotsAsync(shopDAL);
            if (shops == null)
            {
                TempData["Error"] = "Error with shop selection";
                return RedirectToAction("Index", "Home");
            }
            vm.Shop = shops.FirstOrDefault(s => s.Id == shopId) ?? shops[1];

            Customer? thisUser = await Models.User.GetCustomerByIdAsync(userDAL, (int)userId);
            if (thisUser == null)
                return RedirectToAction("Login", "User");

            if (thisUser.Adress != null && vm.Shop.Adress != null)
            {
                double userLon = thisUser.Adress.Longitude;
                double userLat = thisUser.Adress.Latitude;
                if (userLon != -1 && userLat != -1)
                {
                    double distance = vm.Shop.Adress.GetDistanceWith(userLon, userLat);
                    TempData["Distances"] = $"{distance} km";
                }

            }

            return View(vm);
        }

        [HttpPost]
        public async Task<IActionResult> ValidCommand(int shopId, DateTime timeslot)
        {
            int? userId = HttpContext.Session.GetInt32("UserId");
            if (userId == null)
                return RedirectToAction("Login", "User");

            if (shopId == 0 || timeslot == default(DateTime))
            {
                TempData["Error"] = "Take another timeslot";
                return RedirectToAction("Confirm", new { shopId = 1 });
            }

            List<Shop>? shops = await Shop.GetShopsAndTimeslotsAsync(shopDAL);
            if(shops == null)
            {
                TempData["Error"] = "Error with shop selection";
                return RedirectToAction("Index", "Home");
            }

            Shop? thisShop = shops.FirstOrDefault(s => s.Id == shopId);
            if (thisShop == null)
            {
                TempData["Error"] = "Take another shop";
                return RedirectToAction("SelectShop");
            }

            Timeslot? thisTimeslot = thisShop.Timeslots.FirstOrDefault(t => t.StartTime == timeslot);
            if (thisTimeslot == null && thisTimeslot.NumberOfOrders > 9)
            {
                TempData["Error"] = "Take another timeslot";
                return RedirectToAction("Confirm", new { shopId = shopId });
            }
            
            Customer? thisUser = await Models.User.GetCustomerByIdAsync(userDAL, (int)userId);
            if (thisUser == null)
                return RedirectToAction("Login", "User");

            Order thisOrder = new Order(0, OrderStatusEnum.Processing.ToString(), 0, 0, thisTimeslot, thisUser, GetCartFromSession());
            int orderId = await Models.Order.InsertOrderAsync(orderDAL, thisOrder);
            if (orderId == 0)
            {
                TempData["Error"] = "Error for creating the command, try again";
                return RedirectToAction("Index");
            }

            thisOrder.OrderId = orderId;
            int number = await thisOrder.InsertContentAsync(orderDAL);
            if (number > 0)
            {
                TempData["Success"] = $"Order Confirmed at {thisShop.Name} For {thisTimeslot.StartTime.ToString("dd'/'MM'/'yyyy ': between' HH")}h00 and {thisTimeslot.EndTime.ToString("HH")}h00";
                return RedirectToAction("Index", "Home");
            }

            await thisOrder.DeleteOrderAsync(orderDAL);
            TempData["Error"] = "Error in the content of the cart, try again";
            return RedirectToAction("Index");
        }

        public async Task<IActionResult> Index()
        {
            if(HttpContext.Session.GetInt32("UserId") == null)
                return RedirectToAction("Login", "User");

            List<ProductQuantity> validCart = new List<ProductQuantity>();
            bool errorInCart;

            (validCart, errorInCart) = await GetValidatedCartAsync();
            if(errorInCart)
                TempData["Error"] = "WARNING : A product not found was in your list. This product is then removed from your shopping list.";

            SaveCartToSession(validCart);

            return View(validCart);
        }

        public async Task<(List<ProductQuantity>, bool)> GetValidatedCartAsync()
        {
            List<ProductQuantity> cart = GetCartFromSession();
            List<ProductQuantity> validCart = new List<ProductQuantity>();
            bool error = false;

            foreach (ProductQuantity item in cart)
            {
                Product? pt = await Product.GetProductByIdAsync(productDAL, item.GetProductID());

                if (pt == null)
                {
                    error = true;
                }
                else
                {
                    item.Quantity = Math.Clamp(item.Quantity, 1, 500);
                    validCart.Add(item);
                }
            }

            return (validCart, error);
        }
    }
}
