using ClickCollect_Antoine_Nolan_2026.DAL;
using System.ComponentModel.DataAnnotations;
using static System.Runtime.InteropServices.JavaScript.JSType;

namespace ClickCollect_Antoine_Nolan_2026.Models
{
    public class Product
    {
        private int productId;
        private string name = string.Empty;
        private string description = string.Empty;
        private string imageLink = string.Empty;
        private double price = 0.00;
        private List<Category> categoryProduct = new List<Category>();

        public int ProductId
        {
            get { return productId; }
            set { productId = value; }
        }

        [Required(ErrorMessage = "The name must be completed for the product.")]
        [StringLength(100, MinimumLength = 5, ErrorMessage = "The name must be between 5 and 100 characters.")]
        public string Name
        {
            get { return name; }
            set
            {
                value = value.Trim();
                if (string.IsNullOrEmpty(value))
                {
                    throw new ArgumentNullException("Can't be empty");
                }

                name = value;
            }
        }

        [StringLength(500, ErrorMessage = "The description of the product is way too long !")]
        [DataType(DataType.MultilineText)]
        // This will indicate the application that the field description is a long paragraph, not a simple lign text.
        public string Description
        {
            get { return description; }
            set
            {
                if (value == null)
                {
                    throw new ArgumentNullException("Can't be empty");
                }
                value = value.Trim();

                description = value;
            }
        }

        [Required(ErrorMessage = "Each product must have a price !")]
        [Range(0.01, 999.99, ErrorMessage = "The price must be between 0.01 and 999.99.")]
        // Range means here that I don't want any products here that are free (0) or above 1000.
        [DataType(DataType.Currency)]
        // This will be important, to make sure the application knows its a price value, and not a simple double value. 
        [DisplayFormat(DataFormatString = "{0:C}", ApplyFormatInEditMode = false)]
        // Like that, each price will be with 2 decimal. ApplyFormatInEditMode in false will make the € symbol dissapeir.
        // Otherwise, the € would stay, which can lead to a syntax error easily.
        public double Price
        {
            get { return price; }
            set 
            { 
                if (value > 0)
                    price = value; 
            }
        }

        [Required(ErrorMessage = "The image link is required.")]
        [Url(ErrorMessage = "Please provide a valid URL.")] // URL will verify if the string starts with "http://" or "https://"
        [StringLength(500, ErrorMessage = "The URL cannot exceed 500 characters.")]

        public string ImageLink
        {
            get { return imageLink; }
            set
            {
                if (value == null)
                {
                    throw new ArgumentNullException("Can't be empty");
                }
                value = value.Trim();

                imageLink = value;
            }
        }

        [Required(ErrorMessage = "You need at least one category for your product. A product can't be without a category.")]
        [MinLength(1, ErrorMessage = "You should take at least one category.")]
        // I'm checking if the value is null in the property. If its the case, im creating a new list of category.
        public List<Category> CategoryProduct
        {
            get { return categoryProduct; }
            set { categoryProduct = value ?? new List<Category>();}
        }

        // Constructor that accepts a single Category — a product can belong to one or more categories,
        // but it must have at least one. This avoids having to manually create a list before constructing the object.

        public Product(int productId, string name, string description, double price, string imageLink, Category category)
        {
            ProductId = productId;
            Name = name;
            Description = description;
            Price = price;
            ImageLink = imageLink;
            categoryProduct.Add(category ?? throw new ArgumentNullException("There is no category for the product !"));
        }

        public Product(int productId, string name, string description, double price, string imageLink, List<Category> categories)
        {
            ProductId = productId;
            Name = name;
            Description = description;
            Price = price;
            ImageLink = imageLink;
            categoryProduct = categories ?? new List<Category>();
        }

        public Product(int productId, string name, string description, double price, string imageLink)
        {
            ProductId = productId;
            Name = name;
            Description = description;
            Price = price;
            ImageLink = imageLink;
        }

        public Product(int productId, string name, double price, string imageLink)
        {
            ProductId = productId;
            Name = name;
            Price = price;
            ImageLink = imageLink ?? string.Empty;
        }

        public Product()
        {

        }

        public override string ToString()
            => $"{ProductId} : {Name} {Price}";

        public override int GetHashCode()
            => this.ToString().GetHashCode() ;

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

        public bool Equal(Product p)
            => p.ProductId == this.ProductId ;

        // Retrieves all products from the database
        public static async Task<List<Product>> GetCatalogAsync(IProductDAL productDAL)
        {
            return await productDAL.GetAllProductsAsync();
        }

        public static async Task<Product?> GetProductByIdAsync(IProductDAL productDAL, int id)
        {
            return await productDAL.GetProductByIdAsync(id);
        }


    }
}
