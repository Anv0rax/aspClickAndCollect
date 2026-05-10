using Microsoft.AspNetCore.Mvc;

namespace ClickCollect_Antoine_Nolan_2026.Controllers
{
    public class ProductController : Controller
    {
        public IActionResult ViewProduct(int id)
        {
            return View();
        }

        //public async Task<IActionResult> ShowDetails(int id)
        //{
        //    Movie movie = await Movie.GetMovieAsync(id, moviesDAL);
        //    return View(movie);
        //}
    }
}
