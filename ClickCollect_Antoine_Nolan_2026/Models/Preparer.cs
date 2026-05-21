using ClickCollect_Antoine_Nolan_2026.DAL;
using System.ComponentModel.DataAnnotations;

namespace ClickCollect_Antoine_Nolan_2026.Models
{
    public class Preparer : User
    {
        private Shop shop = new Shop();

        public Shop Shop
        {
            get { return shop; }
            set { shop = value ?? throw new ArgumentNullException("Shop can't be null"); }
        }

        public Preparer()
        {

        }

        public Preparer(int id, string username, string password, Shop shop)
            : base(id, username, password)
        {
            Shop = shop;
        }
    }
}
