using ClickCollect_Antoine_Nolan_2026.Models;

namespace ClickCollect_Antoine_Nolan_2026.DAL
{
    public interface IOrderDAL
    {
        public Task<int> InsertOrderAsync(Order order);
        public Task<int> InsertContentAsync(Order order);
        public Task<bool> DeleteOrderAsync(Order order);

        // I will get every command for the next day, for a specific shopId.
        public Task<List<Order>> GetOrdersToPrepareAsync(int shopId);

        public Task<Order?> GetOrderDetailsAsync(int orderId);

        public Task<bool> UpdateOrderStatusAsync(int orderId, OrderStatusEnum status, int numberOfBoxUsed, int boxReturned);

        // This method will be use, so I can get the orders of each customers, and display them.
        public Task<List<Order>> GetOrdersByCustomerAsync(int userId);

        // Récupère uniquement les commandes prêtes (Ready) pour un magasin spécifique
        Task<List<Order>> GetReadyOrdersByShopAsync(int shopId);
    }
}
