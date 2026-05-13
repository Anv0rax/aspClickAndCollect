using ClickCollect_Antoine_Nolan_2026.Models;
using ClickCollect_Antoine_Nolan_2026.DAL;
using Microsoft.AspNetCore.Mvc;

namespace ClickCollect_Antoine_Nolan_2026.Controllers
{
    public class ProductController : Controller
    {

        private readonly IProductDAL productDal;

        public ProductController(IProductDAL productDal)
        {
            this.productDal = productDal;
        }
        //public async Task<IActionResult> ShowDetails(int id)
        //{
        //    Movie movie = await Movie.GetMovieAsync(id, moviesDAL);
        //    return View(movie);
        //}

        public async Task<IActionResult> ViewProduct(int id)
        {
            Product? p = await Product.GetProductByIdAsync(productDal, id);

            if (p == null)
                return View("ProductNotFound");

            return View(p);
        }
    }
}
