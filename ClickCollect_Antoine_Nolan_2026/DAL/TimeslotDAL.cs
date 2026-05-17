using ClickCollect_Antoine_Nolan_2026.Models;
using Microsoft.Data.SqlClient;
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

        public async Task<List<Timeslot>> GetTimeslotsAsync(int shopId)
        {
            List<Timeslot> timeslots = new List<Timeslot>();

            //using (SqlConnection co = new SqlConnection(connectionString))
            //{
            //    SqlCommand cmd = new SqlCommand(
            //        @"SELECT
            //            t.timeslot,
            //            (SELECT COUNT(orderID) 
            //                FROM Orders o 
            //                INNER JOIN Timeslots ts ON o.timeslot = ts.timeslot 
            //                                        and o.shopId = ts.shopId) as ordersPerTimeslot
            //        WHERE t.shopId = @shop
            //        ORDER BY t.timeslot;", co);

            //    cmd.Parameters.Add("@shop", SqlDbType.Int).Value = shopId;

            //    await co.OpenAsync();

            //    using (SqlDataReader reader = await cmd.ExecuteReaderAsync())
            //    {
            //        Timeslot t = new Timeslot()
            //    }
            //}

            return timeslots;
        }
    }
}
