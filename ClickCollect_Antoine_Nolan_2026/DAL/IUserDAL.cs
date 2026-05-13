using ClickCollect_Antoine_Nolan_2026.Models;

namespace ClickCollect_Antoine_Nolan_2026.DAL
{
    public interface IUserDAL
    {
        Task<User?> GetUserByCredentialsAsync(string username, string password);
        // This will retrieves a user, based on the username and the password.

        Task<bool> UsernameExistsAsync(string username);
        // This will verify if the username is not taken by someone.

        Task RegisterCustomerAsync(Customer customer, Adress adressCustomer);
        // This will registers a new customer into the database.

        Task<User?> GetUserByUsernameAsync(string username);
    }
}
