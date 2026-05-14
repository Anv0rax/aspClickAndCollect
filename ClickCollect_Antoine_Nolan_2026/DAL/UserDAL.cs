using ClickCollect_Antoine_Nolan_2026.Models;
using Microsoft.Data.SqlClient;

namespace ClickCollect_Antoine_Nolan_2026.DAL
{
    public class UserDAL : IUserDAL
    {
        private readonly string connectionString;

        public UserDAL(string _connectionString)
        {
            connectionString = _connectionString;
        }

        public async Task<User?> GetUserByCredentialsAsync(string username, string password)
        {
            User? user = null;
            string? hash = null;

            using (SqlConnection co = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand(
                    @"SELECT u.userId, u.username, u.password,
                    CASE
                        WHEN cu.userId IS NOT NULL THEN 'Customer'
                        WHEN ca.userId IS NOT NULL THEN 'Cashier'
                        WHEN p.userId  IS NOT NULL THEN 'Preparer'
                    END AS role,
                    COALESCE(ca.shopId, p.shopId) AS shopId
                    FROM Users u
                    LEFT JOIN Customers cu ON u.userId = cu.userId
                    LEFT JOIN Cachiers  ca ON u.userId = ca.userId
                    LEFT JOIN Preparers p  ON u.userId = p.userId
                    WHERE u.username = @Username", co);
                // COALESCE(ca.shopId, p.shopId) returns the first non-NULL value of the two—if
                // it's a Cashier, ca.shopId will have a value; otherwise, it's p.shopId.

                cmd.Parameters.AddWithValue("Username", username);

                await co.OpenAsync();

                using (SqlDataReader reader = await cmd.ExecuteReaderAsync())
                {
                    if(await reader.ReadAsync())
                    {
                        hash = reader.GetString(2); // This is the hashed password from the DB

                        // now we are going to verify with this fonction of the Bcrypt librairy to see if the password correspond to the hash.
                        if (BCrypt.Net.BCrypt.Verify(password, hash))
                        {
                            int id = reader.GetInt32(0);
                            string uname = reader.GetString(1);
                            string role = await reader.IsDBNullAsync(3) ? "Unknown" : reader.GetString(3);

                            if (role == "Customer")
                                user = new Customer(id, uname, hash);
                            else if (role == "Cashier")
                                user = new Cashier(id, uname, hash, reader.GetInt32(4));
                            else if (role == "Preparer")
                                user = new Preparer(id, uname, hash, reader.GetInt32(4));
                        }
                    }
                }
            }
            return user;
        }

        public async Task<bool> UsernameExistsAsync(string username)
        {
            using (SqlConnection co = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand
                (
                    "SELECT COUNT(*) FROM Users WHERE username = @Username", co
                );

                cmd.Parameters.AddWithValue("Username", username);

                await co.OpenAsync();

                int count = (int)(await cmd.ExecuteScalarAsync())!;
                return count > 0;
            }
        }

        public async Task RegisterCustomerAsync(Customer customer, Adress adress)
        {
            using (SqlConnection co = new SqlConnection(connectionString))
            {
                await co.OpenAsync();

                // Insert the address first and retrieve its generated ID
                SqlCommand cmdAddress = new SqlCommand(
                    @"INSERT INTO Adresses (street, number, city, country)
                        VALUES (@Street, @Number, @City, @Country);
                        SELECT SCOPE_IDENTITY();", co);

                cmdAddress.Parameters.AddWithValue("Street", adress.Street);
                cmdAddress.Parameters.AddWithValue("Number", adress.Number);
                cmdAddress.Parameters.AddWithValue("City", adress.City);
                cmdAddress.Parameters.AddWithValue("Country", adress.Country);

                int addressId = Convert.ToInt32(await cmdAddress.ExecuteScalarAsync());

                string hashedPassword = BCrypt.Net.BCrypt.HashPassword(customer.Password);

                // Insert the user and retrieve its generated ID
                SqlCommand cmdUser = new SqlCommand(
                    @"INSERT INTO Users (firstname, lastname, username, password, adressId)
              VALUES (@Firstname, @Lastname, @Username, @Password, @AddressId);
              SELECT SCOPE_IDENTITY();", co);

                cmdUser.Parameters.AddWithValue("Firstname", customer.FirstName);
                cmdUser.Parameters.AddWithValue("Lastname", customer.LastName);
                cmdUser.Parameters.AddWithValue("Username", customer.Username);
                cmdUser.Parameters.AddWithValue("Password", hashedPassword);
                cmdUser.Parameters.AddWithValue("AddressId", addressId);

                int userId = Convert.ToInt32(await cmdUser.ExecuteScalarAsync());

                // Link the user to the Customers table
                SqlCommand cmdCustomer = new SqlCommand(
                    @"INSERT INTO Customers (userId, email, phoneNumber)
              VALUES (@UserId, @Email, @PhoneNumber)", co);

                cmdCustomer.Parameters.AddWithValue("UserId", userId);
                cmdCustomer.Parameters.AddWithValue("Email", customer.Email);
                cmdCustomer.Parameters.AddWithValue("PhoneNumber", customer.PhoneNumber);

                await cmdCustomer.ExecuteNonQueryAsync();
            }
        }
        public async Task<User?> GetUserByUsernameAsync(string username)
        {
            User? user = null;

            using (SqlConnection co = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand(
                    @"SELECT u.userId, u.username, u.password,
                CASE
                    WHEN cu.userId IS NOT NULL THEN 'Customer'
                    WHEN ca.userId IS NOT NULL THEN 'Cashier'
                    WHEN p.userId  IS NOT NULL THEN 'Preparer'
                END AS role,
                COALESCE(ca.shopId, p.shopId) AS shopId
              FROM Users u
              LEFT JOIN Customers cu ON u.userId = cu.userId
              LEFT JOIN Cachiers  ca ON u.userId = ca.userId
              LEFT JOIN Preparers p  ON u.userId = p.userId
              WHERE u.username = @Username", co);

                cmd.Parameters.AddWithValue("Username", username);

                await co.OpenAsync();

                using (SqlDataReader reader = await cmd.ExecuteReaderAsync())
                {
                    if (await reader.ReadAsync())
                    {
                        int id = reader.GetInt32(0);
                        string uname = reader.GetString(1);
                        string pswrd = reader.GetString(2);
                        string role = await reader.IsDBNullAsync(3)
                                       ? "Unknown"
                                       : reader.GetString(3);

                        if (role == "Customer")
                            user = new Customer(id, uname, pswrd);
                        else if (role == "Cashier")
                            user = new Cashier(id, uname, pswrd, reader.GetInt32(4));
                        else if (role == "Preparer")
                            user = new Preparer(id, uname, pswrd, reader.GetInt32(4));
                    }
                }
            }

            return user;
        }
    }
}
