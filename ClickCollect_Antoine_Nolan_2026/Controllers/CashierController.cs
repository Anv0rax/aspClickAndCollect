using ClickCollect_Antoine_Nolan_2026.DAL;
using ClickCollect_Antoine_Nolan_2026.Models;
using ClickCollect_Antoine_Nolan_2026.ViewModel;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Filters;
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

        public async Task<IActionResult> Payment(int id)
        {
            Console.WriteLine("????????");
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

            return View();
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

            List<Order> oldOrders = new List<Order>();
            foreach (Timeslot ts in theShop.Timeslots)
            {
                if (ts.StartTime < DateTime.Now)
                {
                    foreach (Order o in ts.Orders)
                    {
                        if (o.Status == OrderStatusEnum.Ready)
                            oldOrders.Add(o);
                    }
                }
                else { break; }
            }

            Timeslot slot = theShop.Timeslots?.FirstOrDefault(t 
                => t.StartTime == Timeslot.RoundDateTime(DateTime.Now)) ?? new Timeslot();

            slot.Orders = slot.Orders.Where(o
                => o.Status == OrderStatusEnum.Ready).ToList();

            cashier.ItsShop = theShop;

            CashierViewModel vm = new CashierViewModel();
            vm.Employee = cashier;
            vm.OldOrders = oldOrders;
            vm.Slot = slot;

            return View(vm);
        }
    }
}
