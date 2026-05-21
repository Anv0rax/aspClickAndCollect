using ClickCollect_Antoine_Nolan_2026.DAL;
using System.ComponentModel.DataAnnotations;

namespace ClickCollect_Antoine_Nolan_2026.Models
{
    public class Preparer : User
    {
        private Shop? shop;

        public Shop? Shop
        {
            get { return shop; }
            set { shop = value; }
        }

        public Preparer()
        {

        }

        public Preparer(int id, string username, string password, Shop shop)
            : base(id, username, password)
        {
            Shop = shop;
        }

        public async Task<List<Order>> GetOrdersToPrepareAsync(IOrderDAL orderDAL)
        {
            if (Shop == null) return new List<Order>();
            return await orderDAL.GetOrdersToPrepareAsync(Shop.Id);
        }

        public async Task<Order?> GetOrderDetailsAsync(IOrderDAL orderDAL, int orderId)
            => await orderDAL.GetOrderDetailsAsync(orderId);

        public async Task<bool> UpdateOrderStatusAsync(IOrderDAL orderDAL, int orderId, OrderStatusEnum status, int numberOfBoxUsed)
            => await orderDAL.UpdateOrderStatusAsync(orderId, status, numberOfBoxUsed);
    }
}
