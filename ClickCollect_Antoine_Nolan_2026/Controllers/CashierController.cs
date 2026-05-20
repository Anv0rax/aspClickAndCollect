using ClickCollect_Antoine_Nolan_2026.DAL;
using ClickCollect_Antoine_Nolan_2026.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Filters;
using System.Runtime.InteropServices;

namespace ClickCollect_Antoine_Nolan_2026.Controllers
{
    public class CashierController : BaseController
    {
        private readonly IUserDAL userDAL;
        private readonly IShopDAL shopDAL;

        public CashierController(IUserDAL userDAL, IShopDAL shopDAL)
        {
            this.userDAL = userDAL;
            this.shopDAL = shopDAL;
        }

        public override void OnActionExecuting(ActionExecutingContext context)
        {
            base.OnActionExecuting(context);

            // If the user IS NOT a cashier, he will be redirected to the index.
            RestrictToRole(context, "Cashier");
        }

        public async Task<IActionResult> Index()
        {
            int? userId = HttpContext.Session.GetInt32("UserId");
            if (userId == null)
            {
                TempData["Error"] = "Be connected !";
                return RedirectToAction("Login", "User");
            }

            Cashier? cashier = await Cashier.GetCashierAsync(userDAL, userId.Value);
            if (cashier == null)
            {
                TempData["Error"] = "There is an error with your cashier account";
                return RedirectToAction("Login", "User");
            }

            Shop? theShop = await Shop.GetShopCompleteAsync(shopDAL, cashier.ItsShop.Id);
            if (theShop == null)
            {
                TempData["Error"] = "There is an error with your shop";
                return RedirectToAction("Index", "Home");
            }

            cashier.ItsShop = theShop;

            return View(cashier);
        }
    }
}
