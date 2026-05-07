namespace ClickCollect_Antoine_Nolan_2026.Models
{
    public abstract class User 
    {
        private int id;
        private string username = "";
        private string password = "";

        public User()
        {
            Id = 0;
        }

        public User(int _id, string _username, string _password)
        {
            Id = _id;
            Username = _username;
            Password = _password;
        }

        public int Id
        {
            get => id;
            set => id = value;
        }

        public string Username
        {
            get => username; 
            set
            {
                value = value.Trim();
                if (string.IsNullOrEmpty(value))
                {
                    throw new ArgumentNullException("Conditions aren't respect");
                }
                username = value;
            }
        }

        public string Password
        {
            get { return password; }
            set 
            {
                value = value.Trim();
                if (string.IsNullOrEmpty(value))
                {
                    throw new ArgumentNullException("Conditions aren't respect");
                }
                password = value; 
            }
        }

    }
}
