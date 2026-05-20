using ClickCollect_Antoine_Nolan_2026.Models;

namespace ClickCollect_Antoine_Nolan_2026.DAL
{
    public interface IShopDAL
    {
        public Task<List<Shop>?> GetShopsAndTimeslotsAsync();
        public Task<List<Shop>?> GetShopsAsync();
        public Task<Shop?> GetShopCompleteAsync(int shopId);
    }
}
