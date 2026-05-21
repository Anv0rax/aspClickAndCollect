using ClickCollect_Antoine_Nolan_2026.Models;

namespace ClickCollect_Antoine_Nolan_2026.ViewModel
{
    public class CashierViewModel
    {
        public CashierViewModel() { }

        public List<Order> OldOrders { get; set; }
        public List<Order> TodayOrders { get; set; }
    }
}
