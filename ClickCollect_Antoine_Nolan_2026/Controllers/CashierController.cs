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

        // That means that only the cashier will see the view "Cashier"
        public IActionResult Index()
        {
            return View();
        }
    }
}
