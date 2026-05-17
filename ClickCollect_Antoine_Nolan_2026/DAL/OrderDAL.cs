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

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand(
                        @"INSERT INTO Orders (
                            status, numberOfBoxUsed, numberOfBoxReturned,
                            userId, shopId, timeslot)
                        VALUES (@status, @numberOfBoxUsed, @numberOfBoxReturned,
                            @userId, @shopId, @timeslot)", con);

                cmd.Parameters.AddWithValue("@status", order.Status.ToString());
                cmd.Parameters.AddWithValue("@numberOfBoxUsed", order.NumberOfBoxUsed);
                cmd.Parameters.AddWithValue("@numberOfBoxReturned", order.NumberOfBoxReturned);
                cmd.Parameters.AddWithValue("@userId", order.Client.Id);
                cmd.Parameters.AddWithValue("@shopId", order.Slot.InShop.Id);
                cmd.Parameters.AddWithValue("@timeslot", order.Slot.StartTime);
                await con.OpenAsync();
                int res = await cmd.ExecuteNonQueryAsync();
                succes = res > 0;
            }
            return succes;
        }
    }
}
