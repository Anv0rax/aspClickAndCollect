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
            set { _nameCategory = value ?? throw new ArgumentNullException("The name of the category can't be null."); }
        }

        public Category()
        {

        }

        public Category(int id, string nameCategory)
        {
            Id = id;
            NameCategory = nameCategory;
        }

        public override string ToString()
            => $"{Id} : {NameCategory}";

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

        public bool Equals(Category cat)
            => cat.Id == this.Id;

        public override int GetHashCode()
            => this.ToString().GetHashCode();
    }
}
