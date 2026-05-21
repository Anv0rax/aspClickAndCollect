using ClickCollect_Antoine_Nolan_2026.DAL;
using System.ComponentModel.DataAnnotations;

namespace ClickCollect_Antoine_Nolan_2026.Models
{
    public class Cashier : User
    {
        private Shop shop;

        public Shop ItsShop
        {
            get { return shop; }
            set { shop = value ?? throw new ArgumentNullException("Shop cannot be null."); }
        }

        public Cashier(int _id, string _username, string _password, Shop _shop)
            : base(_id, _username, _password)
        {
            ItsShop = _shop;
        }

        public Cashier(int _id, string _username, string _lastname, string _firstname, Shop _shop)
            : base(_id, _username, _firstname, _lastname)
        {
            ItsShop = _shop;
        }

        public static Task<Cashier?> GetCashierAsync(IUserDAL userDAL, int cashierId)
            => userDAL.GetCashierAsync(cashierId);
    }
}
