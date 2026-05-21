using ClickCollect_Antoine_Nolan_2026.Models;

namespace ClickCollect_Antoine_Nolan_2026.DAL
{
    public interface IRecipeDAL
    {
        Task<List<Recipe>> GetRecipesAsync();

        Task<Recipe?> GetRecipeByIdAsync(int recipeId);
    }
}