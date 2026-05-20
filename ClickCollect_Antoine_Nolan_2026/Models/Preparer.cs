using ClickCollect_Antoine_Nolan_2026.DAL;
using System.ComponentModel.DataAnnotations;

namespace ClickCollect_Antoine_Nolan_2026.Models
{
    public class Preparer : User
    {
        private int? shopId;

        public int? ShopId
        {
            get { return shopId; }
            set { shopId = value; }
        }

        public Preparer()
        {

        }

        public Preparer(int id, string username, string password, int shopId)
            : base(id, username, password)
        {
            ShopId = shopId;
        }

        public async Task<List<Order>> GetOrdersToPrepareAsync(IOrderDAL orderDAL, int shopId)
            => await orderDAL.GetOrdersToPrepareAsync(shopId);

        public async Task<Order?> GetOrderDetailsAsync(IOrderDAL orderDAL, int orderId)
            => await orderDAL.GetOrderDetailsAsync(orderId);
    }
}
