using Microsoft.Data.SqlClient;
using ClickCollect_Antoine_Nolan_2026.Models;

namespace ClickCollect_Antoine_Nolan_2026.DAL
{
public class ProductDAL : IProductDAL
{
    private readonly string connectionString;

    public ProductDAL(string _connectionString)
    {
        connectionString = _connectionString;
    }

        public async Task<List<Product>> GetAllProductsAsync()
        {
            List<Product> products = new List<Product>();

            using (SqlConnection co = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand(
                    @"SELECT p.productId, p.name, p.description, p.price, p.imageLink,
                        c.categoryId, c.label
                        FROM Products p
                        LEFT JOIN ProdCat pc ON p.productId = pc.productId
                        LEFT JOIN Categories c ON pc.categoryId = c.categoryId
                        ORDER BY p.productId", co);

                await co.OpenAsync();

                using (SqlDataReader reader = await cmd.ExecuteReaderAsync())
                {
                    while (await reader.ReadAsync())
                    {
                        int productId = reader.GetInt32(0);

                        Product? product = products.FirstOrDefault(p => p.ProductId == productId);

                        if (product == null)
                        {
                            product = new Product
                            {
                                ProductId   = productId,
                                Name        = reader.GetString(1),
                                Description = reader.GetString(2),
                                Price       = (double)reader.GetDecimal(3),
                                ImageLink   = reader.GetString(4)
                            };
                            products.Add(product);
                        }

                        if (!await reader.IsDBNullAsync(5))
                        {
                            Category c = new Category
                            {
                                Id           = reader.GetInt32(5),
                                NameCategory = reader.GetString(6)
                            };
                            product.CategoryProduct.Add(c);
                        }
                    }
                }
            }

            return products;
        }

        public async Task<Product?> GetProductByIdAsync(int productId)
        {
            Product? product = null;

            using(SqlConnection co = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand
                (
                    @"SELECT p.productId, p.name, p.description, p.price, p.imageLink,
                    c.categoryId, c.label
                    FROM Products p
                    LEFT JOIN ProdCat pc ON p.productId = pc.productId
                    LEFT JOIN Categories c ON pc.categoryId = c.categoryId
                    WHERE p.productId = @ProductId", co
                );

                cmd.Parameters.AddWithValue("ProductId", productId);

                await co.OpenAsync();

                using (SqlDataReader reader = await cmd.ExecuteReaderAsync())
                {
                    while(await reader.ReadAsync())
                    {
                        if(product == null)
                        {
                            product = new Product
                            {
                                ProductId = reader.GetInt32(0),
                                Name = reader.GetString(1),
                                Description = reader.GetString(2),
                                Price = (double)reader.GetDecimal(3),
                                ImageLink = reader.GetString(4)
                            };
                        }

                        if(!await reader.IsDBNullAsync(5))
                        {
                            Category c = new Category
                            {
                                Id = reader.GetInt32(5),
                                NameCategory = reader.GetString(6),
                            };

                            product.CategoryProduct.Add(c);
                        }
                    }
                }
            }

            return product;
        }

        public async Task<List<Product>> SearchProductsAsync(Category? c, string input)
        {
            List<Product> products = new List<Product>();

            using(SqlConnection co = new SqlConnection(connectionString))
            {
                // I will use a dynamic query based on the parameters.
                string query = @"SELECT p.productId, p.name, p.description, p.price, p.imageLink,
                               c.categoryId, c.label
                               FROM Products p
                               LEFT JOIN ProdCat pc ON p.productId = pc.productId
                               LEFT JOIN Categories c ON pc.categoryId = c.categoryId
                               WHERE 1=1";

                // If we have a category, i will add a filter with the category choosen.
                if (c != null)
                    query += " AND pc.categoryId = @CategoryId";

                // If we have put a input, we filter the name of the products.
                if (!string.IsNullOrEmpty(input))
                    query += " AND (p.name LIKE @Input OR p.description LIKE @Input)";

                query += " ORDER BY p.productId";

                SqlCommand cmd = new SqlCommand(query, co);

                if (c != null)
                    cmd.Parameters.AddWithValue("CategoryId", c.Id);

                if (!string.IsNullOrEmpty(input))
                    cmd.Parameters.AddWithValue("Input", $"%{input}%");

                await co.OpenAsync();

                using (SqlDataReader reader = await cmd.ExecuteReaderAsync())
                {
                    while (await reader.ReadAsync())
                    {
                        int productId = reader.GetInt32(0);

                        Product? product = products.FirstOrDefault(p => p.ProductId == productId);

                        if (product == null)
                        {
                            product = new Product
                            {
                                ProductId = productId,
                                Name = reader.GetString(1),
                                Description = reader.GetString(2),
                                Price = (double)reader.GetDecimal(3),
                                ImageLink = reader.GetString(4)
                            };
                            products.Add(product);
                        }

                        if (!await reader.IsDBNullAsync(5))
                        {
                            Category cat = new Category
                            {
                                Id = reader.GetInt32(5),
                                NameCategory = reader.GetString(6)
                            };
                            product.CategoryProduct.Add(cat);
                        }
                    }
                }
            }
            return products;
        }


    }
}
