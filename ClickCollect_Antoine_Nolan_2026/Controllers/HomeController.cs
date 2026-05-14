using System.Diagnostics;
using ClickCollect_Antoine_Nolan_2026.DAL;
using ClickCollect_Antoine_Nolan_2026.Models;
using Microsoft.AspNetCore.Mvc;

namespace ClickCollect_Antoine_Nolan_2026.Controllers
{
    public class HomeController : BaseController
    {
        private readonly IProductDAL productDAL;

        public HomeController(IProductDAL productDAL)
        {
            this.productDAL = productDAL;
        }

        public async Task<IActionResult> Index()
        {
            List<Product> products = await Product.GetCatalogAsync(productDAL);
            return View(products);
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
