namespace ClickCollect_Antoine_Nolan_2026.Models
{
    public class Ingredients
    {
        private Product produit = new Product();
        private int quantity;
        private string unit = string.Empty;

        public Product Product
        {
            get { return produit; }
            set { produit = value ?? throw new ArgumentNullException("The name of a product in the recipe is null."); }
        }

        public int Quantity
        {
            get { return quantity; }
            set
            {
                if (value <= 0)
                    throw new ArgumentOutOfRangeException("The quantity must be higher than 0!");
                quantity = value;
            }
        }

        public string Unit
        {
            get { return unit; }
            set { unit = value ?? string.Empty; }
        }

        public Ingredients()
        {

        }

        public Ingredients(Product product, int quantity, string unit)
        {
            Product = product;
            Quantity = quantity;
            Unit = unit;
        }

        public override string ToString()
            => $"{Product.Name} x {Quantity} {Unit}";

        public override bool Equals(object? obj)
        {
            try
            {
                return obj.ToString() == this.ToString();
            }
            catch { return false; }
        }

        public override int GetHashCode()
            => this.ToString().GetHashCode();
    }
}