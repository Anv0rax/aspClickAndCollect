using System.Text.Json;
using System.Xml.Linq;
using System.Net.Http;
using System.ComponentModel.DataAnnotations;

namespace ClickCollect_Antoine_Nolan_2026.Models
{
    public class Adress
    {
        private int id;
        private string street="";
        private string number="";
        private string city="";
        private string country="";
        private double longitude=-1;
        private double latitude=-1;

        public Adress()
        {

        }

        public Adress(int _id, string _street, string _number, string _city, string _country)    
        {
            id = _id;
            Street = _street;
            Number = _number;
            City = _city;
            country = _country;
        }

        public Adress(int _id, string _street, string _number, string _city, string _country, double _lon, double _lat)
        {
            id = _id;
            Street = _street;
            Number = _number;
            City = _city;
            country = _country;
            longitude = _lon; 
            latitude = _lat;
        }

        public int Id { get => id;  }

        public double Longitude
        {
            get => longitude;
        }

        public double Latitude
        {
            get => latitude;
        }

        [Display(Name = "House number")]
        [Required(ErrorMessage = "Please enter your house number.")]
        [RegularExpression(@"^[-a-zA-Z0-9\. ,]+$", ErrorMessage = "Invalid format for a number.")]
        public string Number
        {
            get => number;
            set => number = value; 
        }

        [Display(Name = "Street")]
        [Required(ErrorMessage = "Please enter your street name.")]
        [RegularExpression(@"^[-a-zA-Z0-9\. ,]+$", ErrorMessage = "Invalid format for a street name.")]
        public string Street
        {
            get => street;
            set { street = value; }
        }

        [Display(Name = "City")]
        [Required(ErrorMessage = "Please enter your city.")]
        [RegularExpression(@"^[-a-zA-Z0-9\. ,]+$", ErrorMessage = "Invalid format for a city name.")]
        public string City
        {
            get => city;
            set
            {
                value = value.Trim();
                if (string.IsNullOrEmpty(value))
                {
                    throw new ArgumentNullException("Can't be empty");
                }

                city = value;
            }
        }

        [Display(Name = "Country")]
        [Required(ErrorMessage = "Please enter your country.")]
        [RegularExpression(@"^[-a-zA-Z0-9\. ,]+$", ErrorMessage = "Invalid format for a country name")]
        public string Country
        {
            get => country;
            set { country = value; }
        }

        public override string ToString()
            => $"{number}, {street}, {city}, {country}";

        public async Task InitLonLatAsync()
        {
            (longitude, latitude) = await GetLonLatAsync(this.ToString());
        }

        public double GetDistanceWith(double lon, double lat)
        {
            if (Longitude != -1 && Latitude != -1)
                return GetDistanceBetween(Longitude, Latitude, lon, lat);
            else 
                throw new Exception("Init lon and lat first");
        }

        public async static Task<(double lon, double lat)> GetLonLatAsync(string address)
        {
            HttpClient api = new HttpClient();
            api.DefaultRequestHeaders.Add("User-Agent", "ClickAndCollectCondorcet/1.0");
            string url = $"https://nominatim.openstreetmap.org/search?q={Uri.EscapeDataString(address)}&format=json&limit=1";

            string json = await api.GetStringAsync(url);
            var results = JsonDocument.Parse(json).RootElement;

            if (results.GetArrayLength() == 0)
            {
                throw new ArgumentException($"Invalid adress : {address}");
            }

            var res = results[0];
            double lon = double.Parse(res.GetProperty("lon").GetString()!, System.Globalization.CultureInfo.InvariantCulture);
            double lat = double.Parse(res.GetProperty("lat").GetString()!, System.Globalization.CultureInfo.InvariantCulture);

            return (lon, lat);
        }


        public static double GetDistanceBetween(double lon1, double lat1, double lon2, double lat2)
        {
            const double Radius = 6371;
            double diffLon = (lon2 - lon1) * Math.PI / 180;
            double diffLat = (lat2 - lat1) * Math.PI / 180;

            double a = Math.Sin(diffLat / 2) * Math.Sin(diffLat / 2)
                     + Math.Cos(lat1 * Math.PI / 180) * Math.Cos(lat2 * Math.PI / 180)
                     * Math.Sin(diffLon / 2) * Math.Sin(diffLon / 2);

            return Radius * 2 * Math.Atan2(Math.Sqrt(a), Math.Sqrt(1 - a));
        }
    }
}
