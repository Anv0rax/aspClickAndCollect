using ClickCollect_Antoine_Nolan_2026.Models;
using Microsoft.Data.SqlClient;
using System.Data;
using System.Diagnostics.Metrics;
using static System.Runtime.InteropServices.JavaScript.JSType;

namespace ClickCollect_Antoine_Nolan_2026.DAL
{
    public class ShopDAL
    {
        private readonly string connectionString;

        public ShopDAL(string _connectionString)
        {
            connectionString = _connectionString;
        }

        public async Task<List<Shop>> GetShopsAsync()
        {
            List<Shop> shops = new List<Shop>();

            using (SqlConnection co = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand(
                    @"SELECT 
                        a.adressId, a.street, a.number, a.city, a.country, a.longitude, a.latitude,
                        s.shopId, s.name, s.maplink, 
                        t.timeslot, t.pickUpTime
                    FROM dbo.Shops s
                    INNER JOIN dbo.Adresses a ON a.adressId = s.adressId
                    LEFT JOIN dbo.Timeslots t ON t.shopId = s.shopId", co);

                await co.OpenAsync();

                using (SqlDataReader reader = await cmd.ExecuteReaderAsync())
                {
                    int shopId = 0;
                    while (await reader.ReadAsync())
                    {
                        if (shopId != reader.GetInt32("shopId"))
                        {
                            shopId = reader.GetInt32("shopId");

                            Adress shopAdress = new Adress(reader.GetInt32("adressld"),
                                reader.GetString("street"), reader.GetString("number"),
                                reader.GetString("city"), reader.GetString("country"),
                                reader.GetDouble("longitude"), reader.GetDouble("latitude"));

                            //Shop? shop = shops.FirstOrDefault(p => p.Id == shopId);

                            //reader.GetString("ShopId");

                            //if (shop == null)
                            //{
                            //    shop = new Shop(shopId, reader.GetString("ShopId"), reader.GetString(2),);
                            //    shops.Add(shop);
                            //}

                            //if (!await reader.IsDBNullAsync(5))
                            //{
                            //    Category c = new Category
                            //    {
                            //        Id = reader.GetInt32(5),
                            //        NameCategory = reader.GetString(6)
                            //    };
                            //    shop.Timeslots.Add(c);
                            //}
                        }
                    }
                }
            }
            return shops;
        }
    }
}
