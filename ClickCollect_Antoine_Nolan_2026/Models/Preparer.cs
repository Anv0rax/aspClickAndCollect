using System.ComponentModel.DataAnnotations;

namespace ClickCollect_Antoine_Nolan_2026.Models
{
    public class Preparer : User
    {
        private int? shopId;

        public int? ShopId
        {
            get { return shopId; }
            set { shopId = value; }
        }

        public Preparer(int id, string username, string password, int shopId)
            : base(id, username, password)
        {
            ShopId = shopId;
        }
    }
}
