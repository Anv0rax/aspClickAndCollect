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
        private List<Timeslot> timeslots = new List<Timeslot>();

        public Shop() { }

        public Shop(int _id, string _name, string _insertMap, Adress _adress)
        {
            Id = _id;
            Name = _name ?? throw new ArgumentNullException(nameof(_name), "There is no name for the shop.");
            InsertMap = _insertMap ?? throw new ArgumentNullException(nameof(_insertMap), "The map of the shop is null.");
            Adress = _adress ?? throw new ArgumentNullException(nameof(_adress), "There is no address for the shop.");
        }

        public Shop(int _id, string _name, string _insertMap, Adress _adress, List<Timeslot> _ts)
            : this(_id, _name, _insertMap, _adress) // i'm just going to use the key word this to use the first constructor.
        {
            Timeslots = _ts;
        }

        public Shop(int _id, string _name, string _insertMap, Adress _adress, Timeslot _ts)
            : this(_id, _name, _insertMap, _adress) // same
        {
            if (_ts != null)
                Timeslots.Add(_ts);
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

        public List<Timeslot> Timeslots
        {
            get { return timeslots; }
            set { timeslots = value ?? new List<Timeslot>(); }
        }

        public override string ToString()
            => $"{Id} : {Name} at {Adress!.ToString()}";

        public override bool Equals(object? obj)
        {
            try
            {
                return this.ToString() == obj!.ToString();
            }
            catch
            {
                return false;
            }
        }

        public bool Equals(Shop s)
            => s.Id == this.Id;

        public override int GetHashCode()
            => this.ToString().GetHashCode();

        public static async Task<List<Shop>?> GetShopsAndTimeslotsAsync(IShopDAL shopDAL)
            => await shopDAL.GetShopsAndTimeslotsAsync();

        public static async Task<List<Shop>?> GetShopsAsync(IShopDAL shopDAL)
            => await shopDAL.GetShopsAsync();
    }
}
