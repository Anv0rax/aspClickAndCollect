using System.Diagnostics;
using ClickCollect_Antoine_Nolan_2026.DAL;
using ClickCollect_Antoine_Nolan_2026.Models;
using Microsoft.AspNetCore.Mvc;

namespace ClickCollect_Antoine_Nolan_2026.Controllers
{
    public class HomeController : BaseController
    {
        private readonly IProductDAL productDAL;
        private readonly IUserDAL userDAL;

        public HomeController(IProductDAL productDAL, IUserDAL userDAL)
        {
            this.productDAL = productDAL;
            this.userDAL = userDAL;
        }
        
        public async Task<IActionResult> Index(string? search = null, string? sort=null, string? category=null)
        {
            List<Product> allProducts = await Product.GetCatalogAsync(productDAL);
            List<Product> catalog;
            ViewData["AllProducts"] = allProducts;

            if (!string.IsNullOrEmpty(search))
            {
                ViewData["Search"] = search;
                search = search.ToLower();
                catalog = allProducts.Where(prod =>
                    prod.Name.ToLower().Contains(search) || prod.Description.ToLower().Contains(search)).ToList();
            }
            else catalog = allProducts;

            catalog = sort switch
            {
                "descending" => catalog.OrderByDescending(p => p.Price).ToList(),
                "ascending" => catalog.OrderBy(p => p.Price).ToList(),
                "name" => catalog.OrderBy(p => p.Name).ToList(),
                _ => catalog
            };


            if (!string.IsNullOrEmpty(category))
            {
                List<Product> sortedCatalog = new List<Product>();
                foreach (Product product in catalog)
                {
                    if (product.CategoryProduct.Any(cat => cat.NameCategory == category))
                    {
                        sortedCatalog.Add(product);
                    }
                }
                catalog = sortedCatalog;

            }

            ViewData["Sort"] = sort;
            ViewData["Category"] = category;
            return View(catalog);
        }

        public IActionResult Privacy()
        {
            return View();
        }

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }
    }
}
