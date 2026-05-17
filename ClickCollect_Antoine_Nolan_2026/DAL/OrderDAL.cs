using ClickCollect_Antoine_Nolan_2026.Models;
using Microsoft.Data.SqlClient;
using System.Data.Common;
using System.Transactions;

namespace ClickCollect_Antoine_Nolan_2026.DAL
{
    public class OrderDAL : IOrderDAL
    {
        private readonly string connectionString;

        public OrderDAL(string _connectionString)
        {
            connectionString = _connectionString;
        }

        public async Task<int> InsertOrderAsync(Order order)
        {
            int orderId = 0;
            try
            {
                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    SqlCommand cmd = new SqlCommand(
                            @"INSERT INTO Orders (
                                status, numberOfBoxUsed, numberOfBoxReturned,
                                userId, shopId, timeslot)
                            OUTPUT INSERTED.orderId
                            VALUES (@status, @numberOfBoxUsed, @numberOfBoxReturned,
                                @userId, @shopId, @timeslot)", con);

                    cmd.Parameters.AddWithValue("@status", order.Status.ToString());
                    cmd.Parameters.AddWithValue("@numberOfBoxUsed", order.NumberOfBoxUsed);
                    cmd.Parameters.AddWithValue("@numberOfBoxReturned", order.NumberOfBoxReturned);
                    cmd.Parameters.AddWithValue("@userId", order.Client.Id);
                    cmd.Parameters.AddWithValue("@shopId", order.Slot.InShop.Id);
                    cmd.Parameters.AddWithValue("@timeslot", order.Slot.StartTime);
                    await con.OpenAsync();
                    var result = await cmd.ExecuteScalarAsync();
                    orderId = result != null ? (int)result : 0;
                }
            }
            catch (Exception ex)
            {
                orderId = 0;
            }
            return orderId;
        }

        public async Task<int> InsertContentAsync(Order order)
        {
            int res = 0;
            try
            {
                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    await con.OpenAsync();

                    foreach (ProductQuantity line in order.Content)
                    {
                        SqlCommand cmd = new SqlCommand(
                            @"INSERT INTO ProductQuantity (productId, orderId, quantity)
                            VALUES (@productId, @orderId, @quantity)", con);

                        cmd.Parameters.AddWithValue("@productId", line.Product.ProductId);
                        cmd.Parameters.AddWithValue("@orderId", order.OrderId);
                        cmd.Parameters.AddWithValue("@quantity", line.Quantity);

                        res += await cmd.ExecuteNonQueryAsync();
                    }
                }
            }
            catch(Exception ex)
            {
                res = 0;
            }
            return res;
        }
    }
}
