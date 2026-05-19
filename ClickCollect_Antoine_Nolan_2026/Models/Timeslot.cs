namespace ClickCollect_Antoine_Nolan_2026.Models
{
    public class Timeslot
    {
        private DateTime timeslot = new DateTime();
        private Shop shop = new Shop();
        private List<Order> orders = new List<Order>();
        private static int maxOrders = 10;

        public Timeslot() { }

        public Timeslot(DateTime _datefrom, Shop _shop)
        {
            StartTime = _datefrom;
            InShop = _shop;
        }

        public Shop InShop
        {
            get { return shop; }
            private set { shop = value; }
        }

        public DateTime StartTime
        {
            get { return timeslot; }
            set { timeslot = new DateTime(value.Year, value.Month, value.Day, value.Hour, 0, 0); }
        }

        public DateTime EndTime
        {
            get => timeslot.AddHours(1);
        }

        public List<Order> Orders
        {
            get => orders;
            private set { orders = value; }
        }

        public void AddOrder(Order o)
        { 
            if(orders.Count < maxOrders && !orders.Contains(o) && o != null)
            {
                orders.Add(o);
            }
        }

        public int NumberOfOrders { get; set; } // because, without that, we sould take all in orders in db

        public override string ToString()
        {
            return $"{InShop.Id}) {StartTime.ToString("dd'/'MM'/'yyyy")} : {StartTime.ToString("HH")} -> {EndTime.ToString("HH")}";
        }

        public bool Equals(Timeslot _ts)
        {
            return _ts.InShop.Id == InShop.Id && _ts.StartTime == StartTime;
        }

        public override bool Equals(object? obj)
        {
            try
            {
                return this.ToString() == obj!.ToString();
            }
            catch
            {
                return false;
            }
        }

        public override int GetHashCode()
        {
            return ToString().GetHashCode();
        }
    }
}
