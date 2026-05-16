using ClickCollect_Antoine_Nolan_2026.DAL;
using ClickCollect_Antoine_Nolan_2026.Models;
using Microsoft.AspNetCore.Mvc;
using System.Text.Json;
using System.Threading.Tasks;

namespace ClickCollect_Antoine_Nolan_2026.Controllers
{
    public class CartController : BaseController
    {
        private readonly IProductDAL productDAL;

        public CartController(IProductDAL productDAL)
        {
            this.productDAL = productDAL;
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
            List<ProductQuantity?> cart = GetCartFromSession();
            cart.RemoveAll(p => p.GetProductID() == productId);
            SaveCartToSession(cart);
            return RedirectToAction("Index");
        }

        [HttpPost]
        public IActionResult UpdateCart(List<ProductQuantity> cart, string action)
        {
            if(!(action == "save" || action == "confirm"))
            { 
                int prodId;

                if(int.TryParse(action, out prodId))
                    cart.RemoveAll(p => p.GetProductID() == prodId);
            }

            SaveCartToSession(cart);

            if(action == "confirm")
            {
                return RedirectToAction("Confirm");
            }
            return RedirectToAction("Index");
        }

        public async Task<IActionResult> Confirm()
        {
            return View("Index");
        }

        public async Task<IActionResult> Index()
        {
            if(HttpContext.Session.GetInt32("UserId") == null)
                return RedirectToAction("Login", "User");

            List<ProductQuantity> cart = GetCartFromSession();
            List<ProductQuantity> validCart = new List<ProductQuantity>();

            foreach(ProductQuantity item in cart)
            {
                Product? pt = await Product.GetProductByIdAsync(productDAL, item.GetProductID());

                if (pt == null)
                    TempData["Error"] = "WARNING : A product not found was in your list. This product is then removed from your shopping list.";
                else
                {
                    item.Quantity = Math.Clamp(item.Quantity, 1, 500);
                    validCart.Add(item);
                }
            }

            SaveCartToSession(validCart);

            return View(validCart);
        }
    }
}
