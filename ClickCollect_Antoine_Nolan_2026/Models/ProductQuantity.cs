using System.ComponentModel.DataAnnotations;

namespace ClickCollect_Antoine_Nolan_2026.Models
{
    public class ProductQuantity
    {
        private Product product;
        private int quantity;

        [Required(ErrorMessage = "To define a product quantity, you need to define a product first.")]

        public Product Product
        {
            get { return product; }
            set { product = value; }
        }

        [Required(ErrorMessage = "Please define the quantity of the product.")]
        [Range(1, 999, ErrorMessage = "Please choose between 1 and 999 products.")]
        // We have to define at least 1 as the quantity of the product, otherwise we could have problems, with -3 bananas on the shopping cart list for example.
        public int Quantity
        {
            get { return quantity; }
            set { quantity = value; }
        }

        public ProductQuantity()
        {
            product = new Product();
        }

        public ProductQuantity(Product p, int quantity)
        {
            Product = p;
            Quantity = quantity;
        }

        // To get a product id :
        public int GetProductID()
        {
            return product.ProductId;
        }
    }
}
