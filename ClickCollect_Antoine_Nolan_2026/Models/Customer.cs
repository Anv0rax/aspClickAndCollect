using System.Text.RegularExpressions;
using System.ComponentModel.DataAnnotations;

namespace ClickCollect_Antoine_Nolan_2026.Models
{
    public class Customer : User
    {
        private string email = string.Empty;
        private string phoneNumber = string.Empty;
        private Adress? adress;

        // The reason im putting string.Empty is because there is a warning that asks the developper to put the
        // variables in non-nullable type. Normally, just putting required in the attribute/property name is enough,
        // but im forced to use string.empty so the warning doesn't appear anymore.

        // Thus, it is really helpful with the required annotation. If the user leave the field empty, it will
        // display directly the required error message.

        [Required(ErrorMessage = "The email is required !")]
        [EmailAddress(ErrorMessage = "Please respect the email format !")]
        [StringLength(254, ErrorMessage = "A email adress can't be above 254 characters.")]
        [RegularExpression(@"^[^@\s]+@[^@\s]+\.[^@\s]{2,}$", ErrorMessage = "The email format is incorrect. Did you forget the extension (e.g., .com, .be)?")]
        public string Email
        {
            get { return email; }
            set { email = value; }
        }

        [Display(Name = "Phone number")]
        [Required(ErrorMessage = "The phone number is required.")]
        [RegularExpression(@"^(\+32\s*|0)[1-9](\s*[0-9]){7,8}\s*$", ErrorMessage = "This phone number is incorrect. Please check if your phone number is from belgium (+32) ?")]
        // This regex expression checks if the phone number is from belgium, and if the string is 7 to 12 digits long
        public string PhoneNumber
        {
            get { return phoneNumber; }
            set { phoneNumber = value; }
        }

        public Adress? Adress
        {
            get { return adress; }
            set { adress = value; }
        }

        public Customer()
        {

        }

        public Customer(int id, string username, string password, string firstName, string lastName, string email, string phoneNumber)
            : base(id, username, password, firstName, lastName)
        {
            Email = email;
            PhoneNumber = phoneNumber;
        }

        public Customer(int id, string username, string password, string firstName, string lastName, string email, string phoneNumber, Adress adress)
            : base(id, username, password, firstName, lastName)
        {
            Email = email;
            PhoneNumber = phoneNumber;
            Adress = adress;
        }

        public Customer(int id, string username, string password)
            : base(id, username, password)
        {
        }
    }
}
