using ClickCollect_Antoine_Nolan_2026.Models;
using Microsoft.Data.SqlClient;
using System.Data;
using System.Security.Cryptography;
using static System.Formats.Asn1.AsnWriter;

namespace ClickCollect_Antoine_Nolan_2026.DAL
{
    public class TimeslotDAL
    {
        private readonly string connectionString;

        public TimeslotDAL(string _connectionString)
        {
            connectionString = _connectionString;
        }

        //public async Task<Timeslot?> GetTimeslotsAsync(int shopId, DateTime ts)
        //{
        //    using (SqlConnection co = new SqlConnection(connectionString))
        //    {
        //        SqlCommand cmd = new SqlCommand(
        //            @"SELECT
        //                s.shopId, s.name, s.maplink, 
        //                a.adressId, a.street, a.number, a.city, a.country, a.longitude, a.latitude,
        //                t.timeslot,
        //                (SELECT COUNT(orderID) 
        //                    FROM Orders o 
        //                    INNER JOIN Timeslots ts ON o.timeslot = ts.timeslot 
        //                                            and o.shopId = ts.shopId) as ordersPerTimeslot
        //            FROM Timeslot t
        //            INNER JOIN Adresses a ON a.adressId = s.adressId
        //            INNER JOIN Shops s ON t.shopId = s.shopId
        //            WHERE t.shopId = @shop
        //            ORDER BY t.timeslot;", co);

        //        cmd.Parameters.AddWithValue("shop", shopId);

        //        await co.OpenAsync();

        //        using (SqlDataReader reader = await cmd.ExecuteReaderAsync())
        //        {
        //            DateTime? currentTimeslot = null;
        //            while (await reader.ReadAsync())
        //            {
        //                if (reader.IsDBNull(reader.GetOrdinal("timeslot")))
        //                    return null;

        //                DateTime rowTimeslot = reader.GetDateTime("shopId");

                        

        //                if (currentTimeslot != rowTimeslot)
        //                {
        //                    shopId = rowTimeslot;

        //                    Adress shopAdress = new Adress(reader.GetInt32("adressId"),
        //                        reader.GetString("street"), reader.GetString("number"),
        //                        reader.GetString("city"), reader.GetString("country"),
        //                        (double)reader.GetDecimal("longitude"), (double)reader.GetDecimal("latitude"));

        //                    currentShop = new Shop(shopId, reader.GetString("name"),
        //                        reader.GetString("maplink"), shopAdress);

        //                    shops.Add(currentShop);
        //                }
        //                if (currentTimeslot != null && !reader.IsDBNull(reader.GetOrdinal("order")))
        //                {
        //                    Order o = new Timeslot(reader.GetDateTime("timeslot"), currentTimeslot);
        //                    if (ts != null)
        //                    {
        //                        ts.NumberOfOrders = reader.GetInt32("ordersPerTimeslot");
        //                        currentShop.Timeslots.Add(ts);
        //                    }
        //                }
        //            }
        //        }
            
        //    }
        //    return timeslots;
        //}
    }
}
