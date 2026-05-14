using System.ComponentModel.DataAnnotations;

namespace ClickCollect_Antoine_Nolan_2026.Models.ViewModels
{
    // This ViewModel groups the Customer data and the Address data into one object.
    // It is used exclusively by the Register view so that asp-for can target
    // both Customer properties and Address properties in the same form.
    public class RegisterViewModel
    {
        // Contains FirstName, LastName, Username, Password, Email, PhoneNumber and AdressCustomer
        public Customer Customer { get; set; } = new Customer();

        public RegisterViewModel()
        {
            // Initialize AdressCustomer to avoid NullReferenceException when the form renders
            Customer.AdressCustomer = new Adress();
        }
    }
}
