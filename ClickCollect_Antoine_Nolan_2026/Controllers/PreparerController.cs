using ClickCollect_Antoine_Nolan_2026.DAL;
using ClickCollect_Antoine_Nolan_2026.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Filters;

namespace ClickCollect_Antoine_Nolan_2026.Controllers
{
    public class PreparerController : BaseController
    {
        private readonly IOrderDAL _orderDAL;

        public PreparerController(IOrderDAL orderDAL)
        {
            _orderDAL = orderDAL;
        }

        public override void OnActionExecuting(ActionExecutingContext context)
        {
            base.OnActionExecuting(context);
            RestrictToRole(context, "Preparer");
        }

        public async Task<IActionResult> Index()
        {
            try
            {
                int shopId = HttpContext.Session.GetInt32("ShopId") ?? 1;

                List<Order> ordersToPrepare = await _orderDAL.GetOrdersToPrepareAsync(shopId);

                return View(ordersToPrepare);
            }
            catch (Exception ex)
            {
                ViewData["Error"] = "An error has occured while loading the orders : " + ex.Message;
                return View(new List<Order>());
            }
        }
    }
}
