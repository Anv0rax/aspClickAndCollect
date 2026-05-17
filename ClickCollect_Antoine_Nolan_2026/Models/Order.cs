namespace ClickCollect_Antoine_Nolan_2026.Models
{
    public class Order
    {
        private int orderId = 0;
        private OrderStatusEnum status = OrderStatusEnum.Processing;
        private int numberOfBoxUsed = 0;
        private int numberOfBoxReturned = 0;
        private Customer customer = new Customer();
        private static double taxOfService = 5.95;
        private static double boxDeposit = 5.95;

        public Order() { }

        public Order(int _orderId, string _status, int _numberOfBoxUsed, int _numberOfBoxReturned, Customer _customer)
        {
            OrderId = _orderId;
            NumberOfBoxUsed = _numberOfBoxUsed;
            NumberOfBoxReturned = _numberOfBoxReturned;
            if (!Enum.TryParse(_status, out OrderStatusEnum Status))
            {
                Status = OrderStatusEnum.Canceled;
            }
            Client = _customer;
        }

        public Customer Client
        {
            get => customer;
            set { customer = value; }
        }

        public int NumberOfBoxReturned
        {
            get => numberOfBoxReturned;
            set { numberOfBoxReturned = value; }
        }

        public int NumberOfBoxUsed
        {
            get => numberOfBoxUsed;
            set { numberOfBoxUsed = value; }
        }

        public OrderStatusEnum Status
        {
            get => status;
            set { status = value; }
        }

        public int OrderId
        {
            get => orderId;
            private set { orderId = value; }
        }

        public bool Equals(Order _o)
        {
            return _o.OrderId == this.OrderId;
        }

        public bool Equals(int _oId)
        {
            return _oId == this.OrderId;
        }

        public override int GetHashCode()
        {
            return this.OrderId.GetHashCode();
        }

        public static double TaxOfService
        {
            get => taxOfService;
        }

        public static double BoxDeposit
        {
            get => boxDeposit;
        }
    }

    public enum OrderStatusEnum
    {
		Processing,
        Ready,
        Fullfilled,
		Canceled
    }
}
