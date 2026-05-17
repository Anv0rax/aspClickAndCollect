using ClickCollect_Antoine_Nolan_2026.DAL;
using ClickCollect_Antoine_Nolan_2026.Models;
using ClickCollect_Antoine_Nolan_2026.ViewModel;
using Microsoft.AspNetCore.Mvc;
using System.Text.Json;
using System.Threading.Tasks;

namespace ClickCollect_Antoine_Nolan_2026.Controllers
{
    public class CartController : BaseController
    {
        private readonly IProductDAL productDAL;
        private readonly IShopDAL shopDAL;

        public CartController(IProductDAL productDAL, IShopDAL shopDAL)
        {
            this.productDAL = productDAL;
            this.shopDAL = shopDAL; 
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
            if (HttpContext.Session.GetInt32("UserId") == null)
                return RedirectToAction("Login", "User");

            List<Shop> shops = await Shop.GetShopsAsync(shopDAL);

            TempData["Distances"] = null;

            //if (User lon != -1 && custo lat != -1)
            //{
            //    List<double> distances = new List<double>();
            //    double userlon = change;
            //    double userlat = change;
            //    for (int i = 0; i < shops.Count; i++)
            //    {
            //        distances.Add(shops[i].Adress!.GetDistanceWith(userlon, userlat));
            //    }
            //    TempData["Distances"] = System.Text.Json.JsonSerializer.Serialize(distances);
            //}

            return View(shops);
        }

        [HttpPost]
        public async Task<IActionResult> Confirm(int shopId)
        {
            if (HttpContext.Session.GetInt32("UserId") == null)
                return RedirectToAction("Login", "User");

            ConfirmCartViewModel vm = new ConfirmCartViewModel();
            vm.Cart = GetCartFromSession();
            List<Shop> shops = await Shop.GetShopsAndTimeslotsFromTodayAsync(shopDAL);

            vm.Shop = shops.FirstOrDefault(s => s.Id == shopId) ?? shops[1];

            return View(vm);
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
