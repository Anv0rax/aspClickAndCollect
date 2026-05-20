using ClickCollect_Antoine_Nolan_2026.Models;
using Microsoft.Data.SqlClient;
using System.Data;
using System.Linq.Expressions;

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
                            {
                                Shop itsShop = new Shop(reader.GetInt32(4));
                                user = new Cashier(id, uname, hash, itsShop);
                            }
                            else if (role == "Preparer")
                            {
                                user = new Preparer(id, uname, hash, reader.GetInt32(4));
                            }
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
                    @"INSERT INTO Adresses (street, number, city, country, longitude, latitude)
                        VALUES (@Street, @Number, @City, @Country, @Longitude, @Latitude);
                        SELECT SCOPE_IDENTITY();", co);

                cmdAddress.Parameters.AddWithValue("Street", adress.Street);
                cmdAddress.Parameters.AddWithValue("Number", adress.Number);
                cmdAddress.Parameters.AddWithValue("City", adress.City);
                cmdAddress.Parameters.AddWithValue("Country", adress.Country);
                cmdAddress.Parameters.AddWithValue("Longitude", adress.Longitude);
                cmdAddress.Parameters.AddWithValue("Latitude", adress.Latitude);

                int addressId = Convert.ToInt32(await cmdAddress.ExecuteScalarAsync());

                string hashedPassword = BCrypt.Net.BCrypt.HashPassword(customer.Password);

                // Insert the user and retrieve its generated ID
                SqlCommand cmdUser = new SqlCommand(
                    @"INSERT INTO Users (firstname, lastname, username, password)
              VALUES (@Firstname, @Lastname, @Username, @Password);
              SELECT SCOPE_IDENTITY();", co);

                cmdUser.Parameters.AddWithValue("Firstname", customer.FirstName);
                cmdUser.Parameters.AddWithValue("Lastname", customer.LastName);
                cmdUser.Parameters.AddWithValue("Username", customer.Username);
                cmdUser.Parameters.AddWithValue("Password", hashedPassword);

                int userId = Convert.ToInt32(await cmdUser.ExecuteScalarAsync());

                // Link the user to the Customers table
                SqlCommand cmdCustomer = new SqlCommand(
                    @"INSERT INTO Customers (userId, email, phoneNumber, adressId)
              VALUES (@UserId, @Email, @PhoneNumber, @AddressId)", co);

                cmdCustomer.Parameters.AddWithValue("UserId", userId);
                cmdCustomer.Parameters.AddWithValue("Email", customer.Email);
                cmdCustomer.Parameters.AddWithValue("PhoneNumber", customer.PhoneNumber);
                cmdCustomer.Parameters.AddWithValue("AddressId", addressId);

                await cmdCustomer.ExecuteScalarAsync();
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
                        {
                            Shop itsShop = new Shop(reader.GetInt32(4));
                            user = new Cashier(id, uname, pswrd, itsShop);
                        }
                        else if (role == "Preparer")
                        {
                            user = new Preparer(id, uname, pswrd, reader.GetInt32(4));
                        }
                    }
                }
            }

            return user;
        }

        public async Task<Customer?> GetCustomerByIdAsync(int userId)
        {
            Customer? customer = null;

            using (SqlConnection co = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand(
                    @"SELECT u.userId, u.username, u.password, u.firstname, u.lastname,
                     cu.email, cu.phoneNumber,
                     a.adressId, a.street, a.number, a.city, a.country, a.longitude, a.latitude
                        FROM Users u
                        INNER JOIN Customers cu ON u.userId = cu.userId
                        INNER JOIN Adresses a ON cu.adressId = a.adressId
                        WHERE u.userId = @UserId", co);

                cmd.Parameters.AddWithValue("UserId", userId);

                await co.OpenAsync();

                using (SqlDataReader reader = await cmd.ExecuteReaderAsync())
                {
                    if (await reader.ReadAsync())
                    {
                        double lon = -1;
                        double lat = -1;

                        if (!reader.IsDBNull(12))
                            lon = (double)reader.GetDecimal(12);

                        if (!reader.IsDBNull(13))
                            lat = (double)reader.GetDecimal(13);

                        Adress adress = new Adress(
                            reader.GetInt32(7),
                            reader.GetString(8),
                            reader.GetString(9),
                            reader.GetString(10),
                            reader.GetString(11),
                            lon, lat
                        );

                        customer = new Customer(
                            reader.GetInt32(0),
                            reader.GetString(1),
                            reader.GetString(2)
                        );

                        customer.FirstName = reader.GetString(3);
                        customer.LastName = reader.GetString(4);
                        customer.Email = reader.GetString(5);
                        customer.PhoneNumber = reader.GetString(6);
                        customer.Adress = adress;
                    }
                }   
            }

            return customer;
        }

        public async Task<Cashier?> GetCashierAsync(int cashierId)
        {
            try
            {
                using (SqlConnection co = new SqlConnection(connectionString))
                {
                    SqlCommand cmd = new SqlCommand(
                        @"SELECT c.userId,
	                        u.username,
	                        u.lastname,
	                        u.firstname,
	                        s.shopId,
	                        s.name

                        FROM cachiers c
                        INNER JOIN users u ON u.userId = c.userId
                        INNER JOIN shops s ON s.shopId = c.shopId
                        WHERE c.userId = @cashierId;", co);

                    cmd.Parameters.AddWithValue("@cashierId", cashierId);
                    await co.OpenAsync();

                    Cashier? cashier = null;
                    Shop? shop = null;

                    using (SqlDataReader reader = await cmd.ExecuteReaderAsync())
                    {
                        while (await reader.ReadAsync())
                        {
                            if (!reader.IsDBNull(reader.GetOrdinal("userId")) && cashier == null)
                            {
                                shop = new Shop(reader.GetInt32("shopId"),
                                    reader.GetString("name"));

                                cashier = new Cashier(reader.GetInt32("userId"),
                                    reader.GetString("username"), reader.GetString("lastname"),
                                    reader.GetString("firstname"), shop);
                            }
                        }
                    }
                    return cashier;
                }
            }
            catch { return null; }
        }
    }
}
