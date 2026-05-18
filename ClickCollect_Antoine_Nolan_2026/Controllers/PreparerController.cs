using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Filters;

namespace ClickCollect_Antoine_Nolan_2026.Controllers
{
    public class PreparerController : BaseController
    {
        public override void OnActionExecuting(ActionExecutingContext context)
        {
            base.OnActionExecuting(context);

            RestrictToRole(context, "Preparer");
        }
        public IActionResult Index()
        {
            return View();
        }
    }
}
