using ClickCollect_Antoine_Nolan_2026.Models;
using Microsoft.Data.SqlClient;
using System.Data;
using System.Diagnostics.Metrics;
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

        public async Task<List<Shop>> GetShopsAndTimeslotsAsync()
        {
            List<Shop> shops = new List<Shop>();

            using (SqlConnection co = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand(
                    @"SELECT 
                        s.shopId, s.name, s.maplink, 
                        a.adressId, a.street, a.number, a.city, a.country, a.longitude, a.latitude,
                        t.timeslot,
                        (SELECT COUNT(orderID) 
                            FROM Orders o 
                            INNER JOIN Timeslots ts ON o.timeslot = ts.timeslot 
                                                    and o.shopId = ts.shopId) as ordersPerTimeslot
                    FROM Shops s
                    INNER JOIN Adresses a ON a.adressId = s.adressId
                    LEFT JOIN Timeslots t ON t.shopId = s.shopId
                    
                    ORDER BY s.shopId;", co);

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

        public async Task<List<Shop>> GetShopsAsync()
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
    }
}
