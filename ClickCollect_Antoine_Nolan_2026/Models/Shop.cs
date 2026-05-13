using System.ComponentModel.DataAnnotations;

namespace ClickCollect_Antoine_Nolan_2026.Models
{
    public class Shop
    {
        private int id;
        private string name = string.Empty;
        private Adress? adress;

        public int Id
        {
            get { return id; }
            private set { id = value; }
        }
        [Required(ErrorMessage = "The shop adress need to be defined.")]
        public Adress? Adress
        {
            get { return adress; }
            set { adress = value; }
        }

        [Required(ErrorMessage = "The shop need a name.")]
        [StringLength(100, MinimumLength = 10, ErrorMessage = "The name must have between 10 and 100 characters.")]
        // The name must be between 10 (minimal length) and 100 (maximal length) characters.
        public string Name
        {
            get { return name; }
            set { name = value; }
        }
    }
}
