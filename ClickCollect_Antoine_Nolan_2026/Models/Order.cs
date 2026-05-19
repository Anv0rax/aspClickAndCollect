using ClickCollect_Antoine_Nolan_2026.DAL;
using System.ComponentModel.DataAnnotations;

namespace ClickCollect_Antoine_Nolan_2026.Models
{
    public class Order
    {
        private int orderId = 0;
        private OrderStatusEnum status = OrderStatusEnum.Processing;
        private int numberOfBoxUsed = 0;
        private int numberOfBoxReturned = 0;
        private Timeslot slot = new Timeslot();
        private Customer customer = new Customer();
        private List<ProductQuantity> content = new List<ProductQuantity>();
        private static double taxOfService = 5.95;
        private static double boxDeposit = 5.95;

        public Order() { }

        public Order(int _orderId, string _status, int _numberOfBoxUsed, int _numberOfBoxReturned, Timeslot _slot, Customer _customer)
        {
            OrderId = _orderId;
            NumberOfBoxUsed = _numberOfBoxUsed;
            NumberOfBoxReturned = _numberOfBoxReturned;
            if (!Enum.TryParse(_status, out OrderStatusEnum Status))
            {
                Status = OrderStatusEnum.Canceled;
            }
            Slot = _slot;
            Client = _customer;
        }

        public Order(int _orderId, string _status, int _numberOfBoxUsed, int _numberOfBoxReturned, Timeslot _slot, Customer _customer, List<ProductQuantity> _content)
            : this (_orderId, _status, _numberOfBoxUsed, _numberOfBoxReturned, _slot, _customer)
        {
            Content = _content;
        }

        public Order(int _orderId, string _status, int _numberOfBoxUsed, int _numberOfBoxReturned, Timeslot _slot, Customer _customer, ProductQuantity _content)
            : this(_orderId, _status, _numberOfBoxUsed, _numberOfBoxReturned, _slot, _customer)
        {
            if (_content != null)
            {
                Content.Add(_content);
            }
        }

        public List<ProductQuantity> Content
        {
            get => content;
            set 
            {
                if (value != null)
                {
                    content = value;
                }
            }
        }

        public Customer Client
        {
            get => customer;
            set { customer = value; }
        }

        public Timeslot Slot
        {
            get => slot;
            set { slot = value; }
        }

        [Range(0,100)]
        [Display(Name = "Number of box returned")]
        public int NumberOfBoxReturned
        {
            get => numberOfBoxReturned;
            set { numberOfBoxReturned = value; }
        }

        [Range(0, 100)]
        [Display(Name = "Number of box used")]
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
            set { orderId = value; }
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

        public bool Equals(Order _o)
        {
            return _o.OrderId == this.OrderId;
        }

        public bool Equals(int _oId)
        {
            return _oId == this.OrderId;
        }

        public override int GetHashCode()
            => this.ToString().GetHashCode();
        
        public static double TaxOfService
        {
            get => taxOfService;
        }

        public static double BoxDeposit
        {
            get => boxDeposit;
        }

        public static async Task<int> InsertOrderAsync(IOrderDAL orderDAL, Order order)
            => await orderDAL.InsertOrderAsync(order);

        public async Task<int> InsertContentAsync(IOrderDAL orderDAL)
            => await orderDAL.InsertContentAsync(this);

        public async Task<bool> DeleteOrderAsync(IOrderDAL orderDAL)
            => await orderDAL.DeleteOrderAsync(this);

        public override string ToString()
            => $"Order number {orderId}";
    }

    public enum OrderStatusEnum
    {
		Processing,
        Ready,
        Fullfilled,
		Canceled
    }
}
