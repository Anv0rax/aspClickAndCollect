using ClickCollect_Antoine_Nolan_2026.DAL;

namespace ClickCollect_Antoine_Nolan_2026.Models
{
    public class Recipe
    {
        private int recipeId;
        private string description = string.Empty;
        private List<Ingredients> ingredients = new List<Ingredients>();

        public int RecipeId
        {
            get { return recipeId; }
            set { recipeId = value; }
        }

        public string Description
        {
            get { return description; }
            set { description = value ?? string.Empty; }
        }

        public List<Ingredients> Ingredients
        {
            get { return ingredients; }
            set { ingredients = value ?? new List<Ingredients>(); }
        }

        public Recipe()
        {

        }

        public Recipe(int recipeId, string description)
        {
            RecipeId = recipeId;
            Description = description;
        }

        public Recipe(int recipeId, string description, Ingredients ingredient)
            : this(recipeId, description)
        {
            if (ingredient != null)
                Ingredients.Add(ingredient);
        }

        public override string ToString()
            => $"Recipe {recipeId} : {description}";

        public override bool Equals(object? obj)
        {
            if (obj is Recipe other)
                return recipeId == other.recipeId;
            return false;
        }

        public override int GetHashCode()
            => this.ToString().GetHashCode();

        public static async Task<List<Recipe>> GetRecipesAsync(IRecipeDAL recipeDAL)
            => await recipeDAL.GetRecipesAsync();

        public static async Task<Recipe?> GetRecipeByIdAsync(IRecipeDAL recipeDAL, int recipeId)
            => await recipeDAL.GetRecipeByIdAsync(recipeId);

    }
}