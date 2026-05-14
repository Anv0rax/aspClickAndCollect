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
        [RegularExpression(@"^[a-zA-Z0-9._-]+$", ErrorMessage = "Username contains invalid characters (only letters, numbers, dots, underscores and hyphens allowed).")]
        public string Username { get; set; } = string.Empty;

        [Display(Name = "Password")]
        [Required(ErrorMessage = "Password is required.")]
        [DataType(DataType.Password)] // We are precising that the string will be a password, which will be helpful for the UI
        [StringLength(100, MinimumLength = 12, ErrorMessage = "Password must be at least 12 characters long.")]

        [RegularExpression(@"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]+$", ErrorMessage = "Password too weak: requires 1 uppercase, 1 lowercase, and one number")]
        // The regex of password: We want at least an uppercase, a lowercase, a number.
        // Here, the (?=.) means that we need in the password at least the input in front of the point.
        // For example, (?=.*\d) means that we need at least a digit.
        public string Password { get; set; } = string.Empty;

        [Display(Name = "Last name")]
        [Required(ErrorMessage = "The name is required to continue.")]
        [RegularExpression(@"^[^\d]+$", ErrorMessage = "The name can't contain any digits. Please delete them.")]
        // The characters ^ means we are not authorizing what's going to be next. \d means any digit, so we don't accept any digits in the name
        [StringLength(50, MinimumLength = 2, ErrorMessage = "The name must have between 2 and 50 characters.")]
        // The name must be between 2 (minimal length) and 50 (maximal length) characters.
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


        // Constructors with no argument and with arguments.
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
