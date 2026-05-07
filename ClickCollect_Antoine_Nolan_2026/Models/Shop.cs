namespace ClickCollect_Antoine_Nolan_2026.Models
{
    public class Shop
    {
        private int id;
        private string name;
        private Adress adress;

        public Adress Adress
        {
            get { return adress; }
            set { adress = value; }
        }


        public string Name
        {
            get { return name; }
            set { name = value; }
        }


        public int Id
        {
            get { return id; }
            set { id = value; }
        }

    }
}
