using System.ComponentModel.DataAnnotations;

namespace ClickCollect_Antoine_Nolan_2026.Models
{
    public class Cashier : User
    {
        private Shop shop;

        public Shop ItsShop
        {
            get { return shop; }
            set { shop = value; }
        }

        public Cashier(int _id, string _username, string _password, Shop _shop)
            : base(_id, _username, _password)
        {
            ItsShop = shop;
        }

    }
}
