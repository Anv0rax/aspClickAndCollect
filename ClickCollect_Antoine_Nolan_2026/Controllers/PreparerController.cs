using ClickCollect_Antoine_Nolan_2026.DAL;
using ClickCollect_Antoine_Nolan_2026.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Filters;

namespace ClickCollect_Antoine_Nolan_2026.Controllers
{
    public class PreparerController : BaseController
    {
        private readonly IOrderDAL orderDAL;

        public PreparerController(IOrderDAL orderDAL)
        {
            this.orderDAL = orderDAL;
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

                List<Order> ordersToPrepare = await Order.GetOrdersToPrepareAsync(orderDAL, shopId);

                return View(ordersToPrepare);
            }
            catch (Exception ex)
            {
                ViewData["Error"] = "An error has occured while loading the orders : " + ex.Message;
                return View(new List<Order>());
            }
        }

        // This will display the details of an spefiic order.
        public async Task<IActionResult> Details(int id)
        {
            try
            {
                Order? order = await Order.GetOrderDetailsAsync(orderDAL, id);

                if (order == null)
                {
                    ViewData["Error"] = "This order could not be found infortunealy.";
                    return RedirectToAction("Index");
                }

                return View(order);
            }
            catch(Exception ex)
            {
                ViewData["Error"] = "An error has occured : " + ex.Message;
                return RedirectToAction("Index");
            }
        }

        // To display the form to start preparing the order
        public async Task<IActionResult> Prepare(int id)
        {
            try
            {
                Order? order = await Order.GetOrderDetailsAsync(orderDAL, id);

                if (order == null)
                {
                    ViewData["Error"] = "This order could not be found.";
                    return RedirectToAction("Index");
                }

                return View(order);
            }
            catch (Exception ex)
            {
                ViewData["Error"] = "An error has occured : " + ex.Message;
                return RedirectToAction("Index");
            }
        }

        // Processes the preparation form and updates the order status
        [ValidateAntiForgeryToken]
        [HttpPost]
        public async Task<IActionResult> Prepare(int id, int numberOfBoxUsed)
        {
            try
            {
                Preparer preparer = new Preparer();
                if (numberOfBoxUsed < 1)
                {
                    ViewData["Error"] = "You must use at least 1 box.";
                    Order? orderError = await Order.GetOrderDetailsAsync(orderDAL, id);
                    return View(orderError);
                }

                await Order.UpdateOrderStatusAsync(orderDAL, id, OrderStatusEnum.Ready, numberOfBoxUsed, 0);
                TempData["Success"] = "The order has been marked as ready.";
                return RedirectToAction("Index");
            }
            catch (Exception ex)
            {
                ViewData["Error"] = "An error has occured : " + ex.Message;
                return RedirectToAction("Index");
            }
        }
    }
}
