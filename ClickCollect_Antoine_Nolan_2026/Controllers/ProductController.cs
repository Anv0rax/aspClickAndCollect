using ClickCollect_Antoine_Nolan_2026.Models;
using ClickCollect_Antoine_Nolan_2026.DAL;
using Microsoft.AspNetCore.Mvc;

namespace ClickCollect_Antoine_Nolan_2026.Controllers
{
    public class ProductController : BaseController
    {

        private readonly IProductDAL productDal;

        public ProductController(IProductDAL productDal)
        {
            this.productDal = productDal;
        }

        public async Task<IActionResult> ViewProduct(int id)
        {
            Product? p = await Product.GetProductByIdAsync(productDal, id);

            if (p == null)
                return View("ProductNotFound");

            ViewData["IsLoggedIn"] = HttpContext.Session.GetInt32("UserId") != null;

            return View(p);
        }
    }
}
