namespace ClickCollect_Antoine_Nolan_2026.Models
{
    public class Order
    {
		private int orderId=0;
		private OrderStatusEnum status=OrderStatusEnum.Processing;
		private int numberOfBoxUsed = 0;
		private int numberOfBoxReturned = 0;
		private static double taxOfService = 5.95;
        private static double boxDeposit = 5.95;

        public Order() { }

        public Order (int _orderId, string _status,  int _numberOfBoxUsed, int _numberOfBoxReturned)
        {
            OrderId = _orderId;
            NumberOfBoxUsed = _numberOfBoxUsed;
            NumberOfBoxReturned = _numberOfBoxReturned;
            if (! Enum.TryParse(_status, out OrderStatusEnum Status))
            {
                Status = OrderStatusEnum.Canceled;
            }
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

	}

    public enum OrderStatusEnum
    {
		Processing,
        Ready,
        Fullfilled,
		Canceled
    }
}
