using ClickCollect_Antoine_Nolan_2026.Models;

namespace ClickCollect_Antoine_Nolan_2026.DAL
{
    public interface IProductDAL
    {
        Task<List<Product>> GetAllProductsAsync();
        // We are going to retrive all the products from the database.

        Task<Product?> GetProductByIdAsync(int productId);
        // So we can get a product with a specific ID !

        Task<List<Product>> SearchProductsAsync(Category? c, string input);
        // To Search a product by category, and/or a input !
    }
}
