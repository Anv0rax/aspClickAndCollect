using ClickCollect_Antoine_Nolan_2026.DAL;
using ClickCollect_Antoine_Nolan_2026.Models;
using ClickCollect_Antoine_Nolan_2026.ViewModel;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Filters;
using Microsoft.VisualBasic;
using System.Runtime.InteropServices;

namespace ClickCollect_Antoine_Nolan_2026.Controllers
{
    public class CashierController : BaseController
    {
        private readonly IUserDAL userDAL;
        private readonly IShopDAL shopDAL;
        private readonly IOrderDAL orderDAL;

        public CashierController(IUserDAL userDAL, IShopDAL shopDAL, IOrderDAL orderDAL)
        {
            this.userDAL = userDAL;
            this.shopDAL = shopDAL;
            this.orderDAL = orderDAL;
        }

        public override void OnActionExecuting(ActionExecutingContext context)
        {
            base.OnActionExecuting(context);

            // If the user IS NOT a cashier, he will be redirected to the index.
            RestrictToRole(context, "Cashier");
        }

        [ValidateAntiForgeryToken]
        [HttpPost]
        public async Task<IActionResult> Confirm(int id, int boxesUsed, int boxesReturned)
        {
            if (HttpContext.Session.GetInt32("UserId") == null)
            {
                TempData["Error"] = "Be connected !";
                return RedirectToAction("Login", "User");
            }
            if(id < 0 || boxesUsed < 0 || boxesReturned < 0)
            {
                TempData["Error"] = "Error with the informations given !";
                return RedirectToAction("Payment", "Cashier", id);
            }

            await Order.UpdateOrderStatusAsync(orderDAL, id, OrderStatusEnum.Fullfilled, boxesUsed, boxesReturned);

            TempData["Success"] = $"{id} valided";
            return RedirectToAction("Index");
        }

        public async Task<IActionResult> Payment(int id)
        {
            if (HttpContext.Session.GetInt32("UserId") == null)
            {
                TempData["Error"] = "Be connected !";
                return RedirectToAction("Login", "User");
            }

            Order? order = await Order.GetOrderDetailsAsync(orderDAL, id);
            if (order == null || order.Status != OrderStatusEnum.Ready)
            {
                TempData["Error"] = "This order doesn't exist or isn't ready !";
                return RedirectToAction("Index", "Cashier");
            }

            TempData["Boxes"] = order.NumberOfBoxUsed;

            return View(order);
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

            List<Order> readyOrders = await orderDAL.GetReadyOrdersByShopAsync(cashier.ItsShop.Id);

            DateTime today = DateTime.Today;
            CashierViewModel vm = new CashierViewModel();

            vm.TodayOrders = readyOrders.Where(o => o.Slot != null && o.Slot.StartTime.Date == today).ToList();
            vm.OldOrders = readyOrders.Where(o => o.Slot != null && o.Slot.StartTime.Date < today).ToList();

            return View(vm);
        }
    }
}
