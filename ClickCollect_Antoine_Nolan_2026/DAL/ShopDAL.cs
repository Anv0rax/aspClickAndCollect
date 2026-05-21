using ClickCollect_Antoine_Nolan_2026.Models;
using Microsoft.Data.SqlClient;
using System.Data;
using System.Diagnostics.Metrics;
using System.Linq.Expressions;
using static System.Runtime.InteropServices.JavaScript.JSType;

namespace ClickCollect_Antoine_Nolan_2026.DAL
{
    public class ShopDAL : IShopDAL
    {
        private readonly string connectionString;

        public ShopDAL(string _connectionString)
        {
            connectionString = _connectionString;
        }

        public async Task<List<Shop>?> GetShopsAndTimeslotsAsync()
        {
            try
            {    
                List<Shop> shops = new List<Shop>();

                using (SqlConnection co = new SqlConnection(connectionString))
                {
                    SqlCommand cmd = new SqlCommand(
                        @"SELECT
                            s.shopId, s.name, s.maplink, 
                            a.adressId, a.street, a.number, a.city, a.country, a.longitude, a.latitude,
                            t.timeslot,
                            COUNT(o.orderId) as ordersPerTimeslot
                        FROM Shops s
                        INNER JOIN Adresses a ON a.adressId = s.adressId
                        LEFT JOIN Timeslots t ON t.shopId = s.shopId
                        LEFT JOIN Orders o ON o.timeslot = t.timeslot AND o.shopId = t.shopId
                        GROUP BY s.shopId, s.name, s.maplink, 
                                 a.adressId, a.street, a.number, a.city, a.country, a.longitude, a.latitude,
                                 t.timeslot
                        ORDER BY s.shopId", co);

                    await co.OpenAsync();

                    using (SqlDataReader reader = await cmd.ExecuteReaderAsync())
                    {
                        int shopId = 0;
                        Shop? currentShop = null;
                        while (await reader.ReadAsync())
                        {
                            int rowShopId = reader.GetInt32("shopId");

                            if (shopId != rowShopId)
                            {
                                shopId = rowShopId;

                                Adress shopAdress = new Adress(reader.GetInt32("adressId"),
                                    reader.GetString("street"), reader.GetString("number"),
                                    reader.GetString("city"), reader.GetString("country"),
                                    (double)reader.GetDecimal("longitude"), (double)reader.GetDecimal("latitude"));

                                currentShop = new Shop(shopId, reader.GetString("name"),
                                    reader.GetString("maplink"), shopAdress);

                                shops.Add(currentShop);
                            }
                            if(currentShop != null && !reader.IsDBNull(reader.GetOrdinal("timeslot")))
                            {
                                Timeslot ts = new Timeslot(reader.GetDateTime("timeslot"), currentShop);
                                if (ts != null)
                                {
                                    ts.NumberOfOrders = reader.GetInt32("ordersPerTimeslot");
                                    currentShop.Timeslots.Add(ts);
                                }
                            }
                        }
                    }
                }
                return shops;
            }
            catch { return null; }
        }

        public async Task<List<Shop>?> GetShopsAsync()
        {
            try
            {
                List<Shop> shops = new List<Shop>();

                using (SqlConnection co = new SqlConnection(connectionString))
                {
                    SqlCommand cmd = new SqlCommand(
                        @"SELECT 
                            s.shopId, s.name, s.maplink, 
                            a.adressId, a.street, a.number, a.city, a.country, a.longitude, a.latitude
                        FROM Shops s
                        INNER JOIN Adresses a ON a.adressId = s.adressId
                    
                        ORDER BY s.shopId;", co);

                    await co.OpenAsync();

                    using (SqlDataReader reader = await cmd.ExecuteReaderAsync())
                    {
                        while (await reader.ReadAsync())
                        {

                            Adress shopAdress = new Adress(reader.GetInt32("adressId"),
                                reader.GetString("street"), reader.GetString("number"),
                                reader.GetString("city"), reader.GetString("country"),
                                (double)reader.GetDecimal("longitude"), (double)reader.GetDecimal("latitude"));

                            shops.Add(new Shop(
                                reader.GetInt32("shopId"), reader.GetString("name"),
                                reader.GetString("maplink"), shopAdress));
                        }
                    }
                }
                return shops;
            }
            catch { return null; }
        }

        public async Task<Shop?> GetShopCompleteAsync(int shopId)
        {
            try
            {    
                using (SqlConnection co = new SqlConnection(connectionString))
                {
                    SqlCommand cmd = new SqlCommand(
                        @"SELECT
                            s.shopId, s.name, s.maplink,
                            a.adressId, a.street, a.number, a.city, a.country, a.longitude, a.latitude,
                            t.timeslot,
                            o.orderId, o.status, o.numberOfBoxUsed, o.numberOfBoxReturned, o.userId,
                            u.firstname, u.lastname, u.username,
                            p.productId, p.name AS productName, p.price, p.imageLink,
                            pq.quantity
                        FROM Timeslots t
                        INNER JOIN Shops s ON t.shopId = s.shopId
                        INNER JOIN Adresses a ON a.adressId = s.adressId
                        LEFT JOIN Orders o ON o.timeslot = t.timeslot AND o.shopId = t.shopId
                        LEFT JOIN Users u ON u.userId = o.userId
                        LEFT JOIN ProductQuantity pq ON pq.orderId = o.orderId
                        LEFT JOIN Products p ON p.productId = pq.productId
                        WHERE s.shopId = @shopId
                        ORDER BY t.timeslot, o.orderId;", co);

                    cmd.Parameters.AddWithValue("@shopId", shopId);
                    await co.OpenAsync();

                    Shop? currentShop = null;
                    Timeslot? currentTimeslot = null;
                    DateTime currentTimeslotDt = DateTime.MinValue;
                    Order? currentOrder = null;
                    int currentOrderId = 0;

                    using (SqlDataReader reader = await cmd.ExecuteReaderAsync())
                    {
                        while (await reader.ReadAsync())
                        {
                            if (currentShop == null)
                            {
                                Adress shopAdress = new Adress(reader.GetInt32("adressId"), 
                                    reader.GetString("street"), reader.GetString("number"), 
                                    reader.GetString("city"), reader.GetString("country"),
                                    (double)reader.GetDecimal("longitude"), (double)reader.GetDecimal("latitude"));

                                currentShop = new Shop(reader.GetInt32("shopId"),
                                    reader.GetString("name"), reader.GetString("maplink"),
                                    shopAdress);
                            }

                            if (!reader.IsDBNull(reader.GetOrdinal("timeslot")))
                            {
                                DateTime ts = reader.GetDateTime("timeslot");
                                if (ts != currentTimeslotDt)
                                {
                                    currentTimeslotDt = ts;
                                    currentTimeslot = new Timeslot(ts, currentShop);
                                    currentShop.Timeslots.Add(currentTimeslot);
                                    currentOrder = null;
                                    currentOrderId = 0;
                                }

                                if (!reader.IsDBNull(reader.GetOrdinal("orderId")))
                                {
                                    int rowOrderId = reader.GetInt32("orderId");
                                    if (rowOrderId != currentOrderId)
                                    {
                                        currentOrderId = rowOrderId;

                                        Customer customer = new Customer(reader.GetInt32("userId"),
                                            reader.GetString("username"), reader.GetString("firstname"), reader.GetString("lastname"));

                                        currentOrder = new Order(rowOrderId,
                                            reader.GetString("status"), reader.GetInt32("numberOfBoxUsed"),
                                            reader.GetInt32("numberOfBoxReturned"), currentTimeslot!, customer);

                                        currentTimeslot!.Orders.Add(currentOrder);
                                    }

                                    if (currentOrder != null && !reader.IsDBNull(reader.GetOrdinal("productId")))
                                    {
                                        Product product = new Product(reader.GetInt32("productId"),
                                            reader.GetString("productName"), (double)reader.GetDecimal("price"),
                                            reader.GetString("imageLink"));

                                        ProductQuantity pq = new ProductQuantity(product, reader.GetInt32("quantity"));
                                        currentOrder.Content.Add(pq);
                                    }
                                }
                            }
                        }
                    }
                    return currentShop;
                }
            }
            catch { return null; }
        }
    }
}
