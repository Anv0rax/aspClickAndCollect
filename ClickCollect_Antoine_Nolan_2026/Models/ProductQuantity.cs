using System.ComponentModel.DataAnnotations;

namespace ClickCollect_Antoine_Nolan_2026.Models
{
    public class ProductQuantity
    {
        private Product product = new Product();
        private int quantity = 0;

        [Required(ErrorMessage = "To define a product quantity, you need to define a product first.")]
        public Product Product
        {
            get { return product; }
            set { product = value; }
        }

        [Range(1, 500)]
        public int Quantity
        {
            get { return quantity; }
            set
            {
                if (value <= 0)
                    throw new ArgumentException("Quantity must be greater than 0.");
                quantity = value;
            }
        }

        public ProductQuantity() { }

        public ProductQuantity(Product p, int quantity)
        {
            Product = p ?? throw new ArgumentNullException("A product is required to put a quantity on it.");
            Quantity = quantity;
        }

        public int GetProductID()
        {
            return product.ProductId;
        }

        public override string ToString()
            => $"The product {product.Name} has, for the quantity, {quantity} unit(s)";

        public override bool Equals(object? obj)
        {
            if (obj is ProductQuantity other)
                return product.ProductId == other.product.ProductId;
            return false;
        }

        public override int GetHashCode()
            => product.ProductId.GetHashCode();

    }
}
