using ClickCollect_Antoine_Nolan_2026.DAL;
using ClickCollect_Antoine_Nolan_2026.Models;
using Microsoft.AspNetCore.Mvc;
using System.Text.Json;

namespace ClickCollect_Antoine_Nolan_2026.Controllers
{
    public class RecipeController : BaseController
    {
        private readonly IRecipeDAL recipeDAL;
        private readonly IProductDAL productDAL;

        public RecipeController(IRecipeDAL recipeDAL, IProductDAL productDAL)
        {
            this.recipeDAL = recipeDAL;
            this.productDAL = productDAL;
        }

        public async Task<IActionResult> Index()
        {
            List<Recipe> recipes = await Recipe.GetRecipesAsync(recipeDAL);
            return View(recipes);
        }

        public async Task<IActionResult> Details(int id)
        {
            Recipe? recipe = await Recipe.GetRecipeByIdAsync(recipeDAL, id);

            if (recipe == null)
            {
                TempData["Error"] = "We could not find this recipe.";
                return RedirectToAction("Index");
            }

            return View(recipe);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]

        public async Task<IActionResult> AddIngredientsToCart(int recipeId)
        {
            if (HttpContext.Session.GetInt32("UserId") == null)
                return RedirectToAction("Login", "User");

            Recipe? recipe = await Recipe.GetRecipeByIdAsync(recipeDAL, recipeId);

            if (recipe == null)
            {
                TempData["Error"] = "We could not find this recipe.";
                return RedirectToAction("Index");
            }
            string? cartJson = HttpContext.Session.GetString("Cart");

            List<ProductQuantity> cart = string.IsNullOrEmpty(cartJson) ? new List<ProductQuantity>() : JsonSerializer.Deserialize<List<ProductQuantity>>(cartJson) ?? new List<ProductQuantity>();

            foreach (Ingredients i in recipe.Ingredients)
            {
                ProductQuantity? existing = cart.FirstOrDefault(p => p.GetProductID() == i.Product.ProductId);

                if (existing != null)
                    existing.Quantity += i.Quantity;
                else
                    cart.Add(new ProductQuantity(i.Product, i.Quantity));
            }

            HttpContext.Session.SetString("Cart", JsonSerializer.Serialize(cart));

            TempData["Success"] = "All the ingredients of the recipe are added to your shopping cart.";
            return RedirectToAction("Index", "Home");
        }
    }
}