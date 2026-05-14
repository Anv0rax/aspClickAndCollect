using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Filters;

namespace ClickCollect_Antoine_Nolan_2026.Controllers
{
    public class BaseController : Controller
    {
        // BaseController is going to override the action OnActionExecuting, from the Controller class.
        // With this, on each action in EVERY other controller will execute the content of my method. It will Execute once per request.
        // Like that, I can check everywhere, without any problems if the user is authentificated or not !

        public override void OnActionExecuting(ActionExecutingContext context)
        {
            ViewData["IsLoggedIn"] = HttpContext.Session.GetInt32("UserId") != null;
            // Since the role of the user is not a attribute in the User class, I will simply stock the
            // role in a temp string : its different from the model !
            ViewData["Role"] = HttpContext.Session.GetString("Role");

            base.OnActionExecuting(context);
        }
    }
}
