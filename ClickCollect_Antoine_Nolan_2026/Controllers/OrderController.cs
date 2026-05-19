using ClickCollect_Antoine_Nolan_2026.DAL;
using ClickCollect_Antoine_Nolan_2026.Models;
using Microsoft.AspNetCore.Mvc;

namespace ClickCollect_Antoine_Nolan_2026.Controllers
{
    public class OrderController : BaseController
    {
        private readonly IOrderDAL orderDAL;

        public OrderController(IOrderDAL orderDAL)
        {
            this.orderDAL = orderDAL;
        }

        // Displays the order history of the logged-in customer
        public async Task<IActionResult> History()
        {
            int? userId = HttpContext.Session.GetInt32("UserId");

            if (userId == null)
                return RedirectToAction("Login", "User");

            List<Order> orders = await Order.GetOrdersByCustomerAsync(orderDAL, userId.Value);
            Console.WriteLine($"Orders count: {orders.Count}");
            foreach (var o in orders)
            {
                Console.WriteLine($"Order {o.OrderId} - Status: {o.Status}");
            }
            return View(orders);
        }
    }
}
