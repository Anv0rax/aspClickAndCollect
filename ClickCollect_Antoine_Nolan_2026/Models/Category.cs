using System.ComponentModel.DataAnnotations;

namespace ClickCollect_Antoine_Nolan_2026.Models
{
    public class Category
    {
        private int _id;
        private string _nameCategory = string.Empty;

        public int Id
        {
            get { return _id; }
            set { _id = value; }
        }

        [Required(ErrorMessage = "You need a name for the category.")]
        [Display(Name = "Category")]
        [StringLength(100, MinimumLength = 3, ErrorMessage = "The length of the name of the category must be between 3 and 100 characters.")]

        public string NameCategory
        {
            get { return _nameCategory; }
            set { _nameCategory = value; }
        }

        public Category()
        {

        }

        public Category(int id, string nameCategory)
        {
            Id = id;
            NameCategory = nameCategory;
        }
    }
}
