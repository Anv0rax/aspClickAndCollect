using ClickCollect_Antoine_Nolan_2026.Models;

namespace ClickCollect_Antoine_Nolan_2026.DAL
{
    public interface IOrderDAL
    {
        public Task<int> InsertOrderAsync(Order order);
        public Task<int> InsertContentAsync(Order order);
        public Task<bool> DeleteOrderAsync(Order order);

        // I will get every command for the next day, for a specific shopId.
        Task<List<Order>> GetOrdersToPrepareAsync(int shopId);
    }
}
