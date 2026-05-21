using ClickCollect_Antoine_Nolan_2026.Models;
using Microsoft.Data.SqlClient;
using System.Data;

namespace ClickCollect_Antoine_Nolan_2026.DAL
{
    public class RecipeDAL : IRecipeDAL
    {
        private readonly string connectionString;

        public RecipeDAL(string _connectionString)
        {
            connectionString = _connectionString;
        }

        public async Task<List<Recipe>?> GetRecipesAsync()
        {
            try
            {
                List<Recipe> recipes = new List<Recipe>();
                using (SqlConnection co = new SqlConnection(connectionString))
                {
                    SqlCommand cmd = new SqlCommand(
                        @"SELECT r.recipeId, r.description,
                            p.productId, p.name, p.price, p.imageLink,
                            i.quantity, i.unit
                        FROM Recipes r
                        LEFT JOIN Ingredients i ON r.recipeId = i.recipeId
                        LEFT JOIN Products p ON i.productId = p.productId
                        ORDER BY r.recipeId", co);

                    await co.OpenAsync();

                    using (SqlDataReader reader = await cmd.ExecuteReaderAsync())
                    {
                        while (await reader.ReadAsync())
                        {
                            int recipeId = reader.GetInt32("recipeId");

                            Recipe? recipe = recipes.FirstOrDefault(r => r.RecipeId == recipeId);

                            if (recipe == null)
                            {
                                recipe = new Recipe(recipeId, reader.IsDBNull("description") ? string.Empty : reader.GetString("description"));
                                recipes.Add(recipe);
                            }

                            if (!reader.IsDBNull(2))
                            {
                                Product product = new Product(reader.GetInt32("productId"),
                                    reader.GetString("name"), (double)reader.GetDecimal("price"),
                                    reader.GetString("imageLink")
                                );

                                Ingredients ingredient = new Ingredients(product, reader.GetInt32("quantity"), reader.IsDBNull("unit") ? string.Empty : reader.GetString("unit"));

                                recipe.Ingredients.Add(ingredient);
                            }
                        }
                    }
                }
                return recipes;
            }
            catch { return null; }
        }

        public async Task<Recipe?> GetRecipeByIdAsync(int recipeId)
        {
            try
            {
                Recipe? recipe = null;

                using (SqlConnection co = new SqlConnection(connectionString))
                {
                    SqlCommand cmd = new SqlCommand(
                        @"SELECT r.recipeId, r.description,
                            p.productId, p.name, p.price, p.imageLink,
                            i.quantity, i.unit
                        FROM Recipes r
                        LEFT JOIN Ingredients i ON r.recipeId = i.recipeId
                        LEFT JOIN Products p ON i.productId = p.productId
                        WHERE r.recipeId = @RecipeId", co);

                    cmd.Parameters.AddWithValue("@RecipeId", recipeId);

                    await co.OpenAsync();

                    using (SqlDataReader reader = await cmd.ExecuteReaderAsync())
                    {
                        while (await reader.ReadAsync())
                        {
                            if (recipe == null)
                            {
                                recipe = new Recipe(reader.GetInt32("recipeId"),
                                    reader.IsDBNull("description") ? string.Empty : reader.GetString("description"));
                            }

                            if (!reader.IsDBNull("productId"))
                            {
                                Product product = new Product(reader.GetInt32("productId"),
                                    reader.GetString("name"), (double)reader.GetDecimal("price"),
                                    reader.GetString("imageLink")
                                );

                                Ingredients ingredient = new Ingredients(product, reader.GetInt32("quantity"),
                                    reader.IsDBNull("unit") ? string.Empty : reader.GetString("unit"));

                                recipe.Ingredients.Add(ingredient);
                            }
                        }
                    }
                }
                return recipe;
        }
            catch { return null; }
        }
    }
}