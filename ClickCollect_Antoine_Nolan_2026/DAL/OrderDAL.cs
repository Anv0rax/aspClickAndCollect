using ClickCollect_Antoine_Nolan_2026.Models;
using Microsoft.Data.SqlClient;

namespace ClickCollect_Antoine_Nolan_2026.DAL
{
    public class OrderDAL : IOrderDAL
    {
        private readonly string connectionString;

        public OrderDAL(string _connectionString)
        {
            connectionString = _connectionString;
        }

        public async Task<bool> InsertOrderAsync(Order order)
        {
            bool succes = false;

            //using (SqlConnection con = new SqlConnection(connectionString))
            //{
            //    SqlCommand cmd = new SqlCommand
            //        (
            //            @"INSERT INTO dbo.Movies (Title, Duration, Synopsis)
            //              VALUES (@Title, @Duration, @Synopsis)"
            //            , con
            //        );
            //    cmd.Parameters.AddWithValue("Title", movie.Title);
            //    cmd.Parameters.AddWithValue("Duration", movie.Duration);
            //    cmd.Parameters.AddWithValue("Synopsis", movie.Synopsis);
            //    await con.OpenAsync();
            //    int res = await cmd.ExecuteNonQueryAsync();
            //    succes = res > 0;
            //}

            return succes;
        }
    }
}
