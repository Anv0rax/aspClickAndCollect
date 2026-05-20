using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Filters;

namespace ClickCollect_Antoine_Nolan_2026.Controllers
{
    public class CashierController : BaseController
    {
        public override void OnActionExecuting(ActionExecutingContext context)
        {
            base.OnActionExecuting(context);

            // If the user IS NOT a cashier, he will be redirected to the index.
            RestrictToRole(context, "Cashier");
        }

        public async Task<IActionResult> Index()
        {
            return View();
        }
    }
}
