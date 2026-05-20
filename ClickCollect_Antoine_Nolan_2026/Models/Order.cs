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
            if (!Enum.TryParse(_status, out OrderStatusEnum parsedStatus))
            {
                this.status = OrderStatusEnum.Canceled;
            }
            else
            {
                this.status = parsedStatus;
            }
            Slot = _slot ?? throw new ArgumentNullException("The timeslot of the order can not be null !");
            Client = _customer ?? throw new ArgumentNullException("The customer of the order must be in the order !");
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

        // This is the estimate price of the products, plus the service fee without any boxes.
        // This will be used to inform the customer of how many euros of the order before the pickup
        public double GetEstimatePrice()
        {
            double total = taxOfService;
            foreach (ProductQuantity pq in content)
                total += pq.Product.Price * pq.Quantity;
            return Math.Round(total, 2);
        }

        // This is the price with the box used : the products + service fee + box caution.
        // This will be used for the cashier, to know how many boxes are added to have the final price !
        public double GetTotalPrice()
        {
            double total = taxOfService;
            total += numberOfBoxUsed * boxDeposit;
            foreach (ProductQuantity pq in content)
                total += pq.Product.Price * pq.Quantity;
            return Math.Round(total, 2);
        }

        // This is the final price : the price of the products + the service fee + the box caution + the box retuned.
        // used for the end of the process order
        public double GetFinalTotalPrice(int boxesReturned)
        {
            if (boxesReturned < 0)
                throw new ArgumentException("Number of boxes returned cannot be negative.");

            double total = taxOfService;
            total += numberOfBoxUsed * boxDeposit;
            total -= boxesReturned * boxDeposit;
            foreach (ProductQuantity pq in content)
                total += pq.Product.Price * pq.Quantity;
            return Math.Round(total, 2);
        }

        // Ajoute une ligne de commande — si le produit existe déjà, augmente la quantité
        // This add a new order
        // checks if the products aleardy exist. If thats the case, we increase the quantity.
        public void AddOrderLine(ProductQuantity pq)
        {
            if (pq == null)
                throw new ArgumentNullException("ProductQuantity cannot be null.");
            if (pq.Quantity <= 0)
                throw new ArgumentException("Quantity must be greater than 0.");

            ProductQuantity? existing = content.FirstOrDefault(p => p.GetProductID() == pq.GetProductID());
            if (existing != null)
                existing.Quantity += pq.Quantity;
            else
                content.Add(pq);
        }

        // This deletes a order by orderId.
        public void RemoveOrderLine(int productId)
        {
            ProductQuantity? existing = content.FirstOrDefault(p => p.GetProductID() == productId);
            if (existing != null)
                content.Remove(existing);
            else
                throw new KeyNotFoundException($"No order line found for product ID {productId}.");
        }

        // Check if the product is aleardy in the command.
        public bool ContainsProduct(int productId)
        {
            return content.Any(p => p.GetProductID() == productId);
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

        public static async Task<List<Order>> GetOrdersByCustomerAsync(IOrderDAL orderDAL, int userId)
            => await orderDAL.GetOrdersByCustomerAsync(userId);

        public async Task<bool> UpdateStatusAsync(IOrderDAL orderDAL, OrderStatusEnum newStatus, int numberOfBoxes)
        {
            if (numberOfBoxes < 0)
                throw new ArgumentException("Number of boxes cannot be negative.");
            this.status = newStatus;
            this.numberOfBoxUsed = numberOfBoxes;
            return await orderDAL.UpdateOrderStatusAsync(this.orderId, newStatus, numberOfBoxes);
        }

        public override string ToString()
            => $"Order {orderId} - {status} - {slot?.StartTime:dd/MM/yyyy} - {customer?.Username}";
    }

    public enum OrderStatusEnum
    {
		Processing,
        Ready,
        Fullfilled,
		Canceled
    }
}
