using ClickCollect_Antoine_Nolan_2026.Models;

namespace ClickCollect_Antoine_Nolan_2026.DAL
{
    public interface IOrderDAL
    {
        public Task<bool> InsertOrderAsync(Order order);
    }
}
