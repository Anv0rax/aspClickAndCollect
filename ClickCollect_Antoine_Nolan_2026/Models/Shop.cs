using ClickCollect_Antoine_Nolan_2026.DAL;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;

namespace ClickCollect_Antoine_Nolan_2026.Models
{
    public class Shop
    {
        private int id;
        private string name = string.Empty;
        private string insertMap = string.Empty;
        private Adress? adress;

        public Shop() { }

        public Shop(int _id, string _name, string _insertMap, Adress _adress)
        {
            Id = _id;
            Name = _name;
            InsertMap = _insertMap;
            Adress = _adress;
        }

        public int Id
        {
            get { return id; }
            private set { id = value; }
        }

        [Required(ErrorMessage = "The shop adress need to be defined.")]
        public Adress? Adress
        {
            get { return adress; }
            set { adress = value; }
        }

        [Required(ErrorMessage = "The shop need a name.")]
        [StringLength(100, MinimumLength = 5, ErrorMessage = "The name must have between 5 and 100 characters.")]
        // The name must be between 5 (minimal length) and 100 (maximal length) characters.
        public string Name
        {
            get { return name; }
            set { name = value; }
        }

        public string InsertMap
        {
            get => insertMap;
            private set => insertMap = value;
        }

        public List<Timeslot> Timeslots { get; set; }

        public static async Task<List<Shop>> GetShopsAndTimeSlotsFromTodayAsync(IShopDAL shopDAL)
            => await shopDAL.GetShopsAndTimeslotsFromNowAsync();
    }
}
