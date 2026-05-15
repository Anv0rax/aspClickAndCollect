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

            if (quantity < 1 || quantity > 999)
            {
                TempData["Error"] = "Please choose between 1 and 999 products.";
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

        // i will add a new method, to simply delete a product from the shopping list of the customer
        // For that, i will use a lambda expression, to remove all the products where the productID is the same as the id from the parameters of the method.
        // Then of course i will save the cart.

        [HttpPost]
        public IActionResult RemoveFromCart(int productId)
        {
            List<ProductQuantity?> cart = GetCartFromSession();
            cart.RemoveAll(p => p.GetProductID() == productId);
            SaveCartToSession(cart);
            return RedirectToAction("Index");
        }

        // I'm going to check if every product in the shopping list are in the database.
        // For that, i will get the cart of the user, and for each product, im checking his ID.
        // By getting all the product ID, I can tell with the method GetProductByIdAsync if one product is not in the database.
        // Those products will be deleted from the user cart, by just not adding them into the validCart list.
        // I will save the new list, and return the view with the ValidCart.

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
                    validCart.Add(item);
            }

            SaveCartToSession(validCart);

            return View(validCart);
        }
    }
}
