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

        [Range(0, 500)]
        public int Quantity
        {
            get { return quantity; }
            set { quantity = value; }
        }

        public ProductQuantity() { }

        public ProductQuantity(Product p, int quantity)
        {
            Product = p;
            Quantity = quantity;
        }

        public int GetProductID()
        {
            return product.ProductId;
        }
    }
}
