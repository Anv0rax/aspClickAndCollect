using ClickCollect_Antoine_Nolan_2026.DAL;
using System.ComponentModel.DataAnnotations;
using System.Xml.Linq;

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
            set { id = value; }
        }

        [Display(Name = "Username")]
        [Required(ErrorMessage = "Username is required.")]
        [StringLength(25, MinimumLength = 4, ErrorMessage = "Username must be between 4 and 25 characters.")]
        [RegularExpression(@"^[-a-zA-Z0-9_]+$", ErrorMessage = "Username contains invalid characters.")]
        public string Username
        {
            get { return username; }
            set
            {
                value = value.Trim();
                if (string.IsNullOrEmpty(value))
                {
                    throw new ArgumentNullException("Username can't be empty");
                }

                username = value;
            }
        }

        [Display(Name = "Password")]
        [Required(ErrorMessage = "Password is required.")]
        [DataType(DataType.Password)]
        [StringLength(100, MinimumLength = 12, ErrorMessage = "Must be at least 12 characters long.")]

        [RegularExpression(@"^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9]).{12,40}$", ErrorMessage = "Requires at least 12 characters with 1 uppercase, 1 lowercase and 1 number")]
        public string Password
        {
            get { return password; }
            set
            {
                value = value.Trim();
                if (string.IsNullOrEmpty(value))
                {
                    throw new ArgumentNullException("Password can't be empty");
                }

                password = value;
            }
        }

        [Display(Name = "Last name")]
        [Required(ErrorMessage = "The name is required to continue.")]
        [RegularExpression(@"^[^\d]+$", ErrorMessage = "The name can't contain any digits. Please delete them.")]
        [StringLength(50, MinimumLength = 2, ErrorMessage = "The name must have between 2 and 50 characters.")]
        public string LastName
        {
            get { return lastName; }
            set
            {
                value = value.Trim();
                if (string.IsNullOrEmpty(value))
                {
                    throw new ArgumentNullException("Lastname can't be empty");
                }

                lastName = value;
            }
        }

        [Display(Name = "First name")]
        [Required(ErrorMessage = "The firstname is required to continue.")]
        [RegularExpression(@"^[^\d]+$", ErrorMessage = "The firstname can't contain any digits. Please delete them.")]
        [StringLength(50, MinimumLength = 2, ErrorMessage = "The firstname must have between 2 and 50 characters.")]
        public string FirstName 
        {
            get { return firstName; }
            set
            {
                value = value.Trim();
                if (string.IsNullOrEmpty(value))
                {
                    throw new ArgumentNullException("Firstname can't be empty");
                }

                firstName = value;
            }
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

        public User(int id, string username, string firstName, string lastName)
        {
            Id = id;
            Username = username;
            FirstName = firstName;
            LastName = lastName;
        }

        public User(int id, string username, string password, string firstName, string lastName)
            : this(id, username, password)
        {
            FirstName = firstName;
            LastName = lastName;
        }

        public override string ToString()
            => $"{Id} : {Username}";

        public override int GetHashCode()
            => this.ToString().GetHashCode();

        public override bool Equals(object? obj)
        {
            try
            {
                return base.ToString() == obj!.ToString();
            }
            catch
            {
                return false;
            }
        }

        public bool Equals(User u)
            => u.Id == this.Id;

        public static async Task<User ?> GetUserByCredentialsAsync(IUserDAL userDAL, string username, string password)
        {
            return await userDAL.GetUserByCredentialsAsync(username, password);
        }
        // it will retrive a user from the database based on username and password

        public static async Task<bool> UsernameExistsAsync(IUserDAL userDAL, string username)
        {
            return await userDAL.UsernameExistsAsync(username);
        }
        public static async Task RegisterCustomerAsync(IUserDAL userDAL, Customer customer, Adress adress)
        {
            await userDAL.RegisterCustomerAsync(customer, adress);
        }

        public static async Task<User?> GetUserByUsernameAsync(IUserDAL userDAL, string username)
        {
            return await userDAL.GetUserByUsernameAsync(username);
        }

        public static async Task<Customer?> GetCustomerByIdAsync(IUserDAL userDAL, int userId)
        {
            return await userDAL.GetCustomerByIdAsync(userId);
        }
    }
}
