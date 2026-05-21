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

        public Timeslot(DateTime _datefrom, Shop _shop, Order _order)
            : this(_datefrom, _shop)
        {
            if (_order != null)
                orders.Add(_order);
        }

        public Shop InShop
        {
            get { return shop; }
            set { shop = value ?? throw new ArgumentNullException("The shop is required to to put the timeslot !"); }
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
            set 
            {
                if (value == null || value.Count > MaxOrders)
                    throw new ArgumentException($"Orders can't be null ! or more than {MaxOrders}");
                orders = value; 
            }
        }

        public static int MaxOrders
        {
            get => maxOrders; 
        }

        public void AddOrder(Order o)
        { 
            if(orders.Count < maxOrders && o != null && !orders.Contains(o) )
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