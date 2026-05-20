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

        public async Task<bool> DeleteOrderAsync(Order order)
        {
            bool res = false;
            try
            {
                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    await con.OpenAsync();

                    SqlCommand cmdPq = new SqlCommand(
                        @"DELETE FROM ProductQuantity
                        WHERE orderId = @orderId", con);
                    cmdPq.Parameters.AddWithValue("@orderId", order.OrderId);
                    await cmdPq.ExecuteNonQueryAsync();

                    SqlCommand cmdOrder = new SqlCommand(
                        @"DELETE FROM Orders
                        WHERE orderId = @orderId", con);
                    cmdOrder.Parameters.AddWithValue("@orderId", order.OrderId);
                    await cmdOrder.ExecuteNonQueryAsync();

                    res = true;
                }
            }
            catch (Exception ex)
            {
                res = false;
            }
            return res;
        }

        public async Task<List<Order>> GetOrdersToPrepareAsync(int shopId)
        {
            var orders = new List<Order>();

            DateTime nextDay = DateTime.Now.AddHours(24);
            
            string query = @"SELECT o.orderId AS OrderId, o.status AS OrderStatus, 
                            o.numberOfBoxUsed AS BoxUsed, o.numberOfBoxReturned AS BoxReturned,
                            o.timeslot AS OrderTime, u.userId AS CustomerId, u.username AS CustomerName
                                 FROM Orders o
                                 INNER JOIN Users u ON o.userId = u.userId
                                 WHERE o.shopId = @ShopId
                                   AND CONVERT(date, o.timeslot) = CONVERT(date, @NextDay)
                                   AND o.status = 'Processing'";

            using (SqlConnection co = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, co))
                {
                    cmd.Parameters.AddWithValue("@ShopId", shopId);
                    cmd.Parameters.AddWithValue("@NextDay", nextDay);

                    await co.OpenAsync();

                    using (SqlDataReader reader = await cmd.ExecuteReaderAsync())
                    {
                        while (await reader.ReadAsync())
                        {
                            // im going to create the customer => (u.userId -> CustomerId, u.username -> CustomerName)
                            Customer customer = new Customer
                            {
                                Id = reader.GetInt32(reader.GetOrdinal("CustomerId")),
                                Username = reader.GetString(reader.GetOrdinal("CustomerName"))
                            };

                            // then i create the timeslot => (o.timeslot -> OrderTime)
                            Timeslot timeslot = new Timeslot
                            {
                                StartTime = reader.GetDateTime(reader.GetOrdinal("OrderTime"))
                            };

                            // using the order constructor to then init every part of the order.
                            Order order = new Order(
                                reader.GetInt32(reader.GetOrdinal("OrderId")),
                                reader.GetString(reader.GetOrdinal("OrderStatus")),
                                reader.GetInt32(reader.GetOrdinal("BoxUsed")),
                                reader.GetInt32(reader.GetOrdinal("BoxReturned")),
                                timeslot,
                                customer
                            );

                            orders.Add(order);
                        }
                    }
                }
            }
            return orders;
        }

        public async Task<Order?> GetOrderDetailsAsync(int orderId)
        {
            Order? order = null;

            using (SqlConnection co = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand(
                     @"SELECT o.orderId, o.status, o.numberOfBoxUsed, o.numberOfBoxReturned,
                     o.timeslot, u.userId, u.username,
                     p.productId, p.name, p.price, p.imageLink, pq.quantity
                        FROM Orders o
                          INNER JOIN Users u ON o.userId = u.userId
                          LEFT JOIN ProductQuantity pq ON o.orderId = pq.orderId
                          LEFT JOIN Products p ON pq.productId = p.productId
                          WHERE o.orderId = @OrderId", co);

                cmd.Parameters.AddWithValue("@OrderId", orderId);

                await co.OpenAsync();

                using (SqlDataReader reader = await cmd.ExecuteReaderAsync())
                {
                    while (await reader.ReadAsync())
                    {
                        if(order == null)
                        {
                            Customer customer = new Customer(
                                reader.GetInt32(5),
                                reader.GetString(6),
                                string.Empty
                            );

                            Timeslot timeslot = new Timeslot
                            {
                                StartTime = reader.GetDateTime(4)
                            };

                            order = new Order(
                                reader.GetInt32(0),
                                reader.GetString(1),
                                reader.GetInt32(2),
                                reader.GetInt32(3),
                                timeslot,
                                customer
                            );
                        }

                        if(!await reader.IsDBNullAsync(7))
                        {
                            Product product = new Product
                            (reader.GetInt32(7), reader.GetString(8), (double)reader.GetDecimal(9), reader.GetString(10)
                            );

                            order.Content.Add(new ProductQuantity(product, reader.GetInt32(11)));
                        }
                    }
                }
            }
            return order;
        }

        public async Task<bool> UpdateOrderStatusAsync(int orderId, OrderStatusEnum status, int numberOfBoxUsed, int boxReturned=0)
        {
            using (SqlConnection co = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand(
                    @"UPDATE Orders 
              SET status = @Status, numberOfBoxUsed = @NumberOfBoxUsed, numberOfBoxReturned = @numberOfBoxReturned
              WHERE orderId = @OrderId", co);

                cmd.Parameters.AddWithValue("@Status", status.ToString());
                cmd.Parameters.AddWithValue("@NumberOfBoxUsed", numberOfBoxUsed);
                cmd.Parameters.AddWithValue("@NumberOfBoxReturned", boxReturned);
                cmd.Parameters.AddWithValue("@OrderId", orderId);

                await co.OpenAsync();

                int rows = await cmd.ExecuteNonQueryAsync();
                return rows > 0;
            }
        }

        public async Task<List<Order>> GetOrdersByCustomerAsync(int userId)
        {
            List<Order> orders = new List<Order>();

            using (SqlConnection co = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand(
                    @"SELECT o.orderId, o.status, o.numberOfBoxUsed, 
                     o.numberOfBoxReturned, o.timeslot,
                     s.name AS shopName
              FROM Orders o
              INNER JOIN Shops s ON o.shopId = s.shopId
              WHERE o.userId = @UserId
              ORDER BY o.timeslot DESC", co);

                cmd.Parameters.AddWithValue("@UserId", userId);

                await co.OpenAsync();

                using (SqlDataReader reader = await cmd.ExecuteReaderAsync())
                {
                    while (await reader.ReadAsync())
                    {
                        Timeslot timeslot = new Timeslot
                        {
                            StartTime = reader.GetDateTime(4)
                        };

                        // Store shop name in timeslot's shop
                        Shop shop = new Shop
                        {
                            Name = reader.GetString(5)
                        };
                        timeslot.InShop = shop;

                        Order order = new Order(
                            reader.GetInt32(0),
                            reader.GetString(1),
                            reader.GetInt32(2),
                            reader.GetInt32(3),
                            timeslot,
                            new Customer()
                        );

                        orders.Add(order);
                    }
                }
            }

            return orders;
        }
    }
}
