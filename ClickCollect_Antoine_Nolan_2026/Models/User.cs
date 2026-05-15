using System.ComponentModel.DataAnnotations;

namespace ClickCollect_Antoine_Nolan_2026.Models
{
    public abstract class User
    {
        private int id;
        private string username = string.Empty;
        private string password = string.Empty;
        private string firstName = string.Empty;
        private string lastName = string.Empty;

        public int Id
        {
            get { return id; }
            private set { id = value; }
        }

        [Display(Name = "Username")]
        [Required(ErrorMessage = "Username is required.")]
        [StringLength(25, MinimumLength = 4, ErrorMessage = "Username must be between 4 and 25 characters.")]
        [RegularExpression(@"^[a-zA-Z0-9._-]+$", ErrorMessage = "Username contains invalid characters.")]
        public string Username { get; set; } = string.Empty;

        [Display(Name = "Password")]
        [Required(ErrorMessage = "Password is required.")]
        [DataType(DataType.Password)]
        [StringLength(100, MinimumLength = 12, ErrorMessage = "Must be at least 12 characters long.")]

        [RegularExpression(@"^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9]).{12,40}$", ErrorMessage = "Requires at least 12 characters with 1 uppercase, 1 lowercase, and one number")]
        public string Password { get; set; } = string.Empty;

        [Display(Name = "Last name")]
        [Required(ErrorMessage = "The name is required to continue.")]
        [RegularExpression(@"^[^\d]+$", ErrorMessage = "The name can't contain any digits. Please delete them.")]
        [StringLength(50, MinimumLength = 2, ErrorMessage = "The name must have between 2 and 50 characters.")]
        public string LastName
        {
            get { return lastName; }
            set { lastName = value; }
        }

        [Display(Name = "First name")]
        [Required(ErrorMessage = "The firstname is required to continue.")]
        [RegularExpression(@"^[^\d]+$", ErrorMessage = "The firstname can't contain any digits. Please delete them.")]
        [StringLength(50, MinimumLength = 2, ErrorMessage = "The firstname must have between 2 and 50 characters.")]
        public string FirstName 
        {
            get { return firstName; }
            set { firstName = value; }
        }


        public User()
        {

        }

        public User(int id, string username, string password)
        {
            Id = id;
            Username = username;
            Password = password;
        }

        public User(int id, string username, string password, string firstName, string lastName)
        {
            Id = id;
            Username = username;
            Password = password;
            FirstName = firstName;
            LastName = lastName;
        }
    }
}
