using System.Diagnostics;
using ClickCollect_Antoine_Nolan_2026.DAL;
using ClickCollect_Antoine_Nolan_2026.Models;
using Microsoft.AspNetCore.Mvc;

namespace ClickCollect_Antoine_Nolan_2026.Controllers
{
    public class HomeController : Controller
    {
        private readonly IProductDAL productDAL;

        public HomeController(IProductDAL productDAL)
        {
            this.productDAL = productDAL;
        }
        
        public async Task<IActionResult> Index(string? sort=null, string? category=null)
        {
            List<Product> catalog = await Product.GetCatalogAsync(productDAL);
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
