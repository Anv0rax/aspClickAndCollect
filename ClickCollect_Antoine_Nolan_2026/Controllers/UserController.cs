using BCrypt.Net;
using ClickCollect_Antoine_Nolan_2026.DAL;
using ClickCollect_Antoine_Nolan_2026.Models;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace ClickCollect_Antoine_Nolan_2026.Controllers
{
    public class UserController : BaseController
    {
        private readonly IUserDAL userDAL;

        public UserController(IUserDAL userDAL)
        {
            this.userDAL = userDAL;
        }

        // This will check if the user is aleady authentificated. If it's the case, he's directly directed to the catalog.
        public IActionResult Login()
        {
            if (HttpContext.Session.GetInt32("UserId") != null)
            {
                string? userRole = HttpContext.Session.GetString("Role");

                if (userRole == "Preparer") return RedirectToAction("Index", "Preparer");
                if (userRole == "Cashier") return RedirectToAction("Index", "Cashier");
                
                return RedirectToAction("Index", "Home");
            }

            return View();
        }

        [HttpPost]
        public async Task<IActionResult> Login(string username, string password)
        {
            if (string.IsNullOrEmpty(username) || string.IsNullOrEmpty(password))
            {
                ViewData["Error"] = "The username or password is missing.";
                return View();
            }

            if (HttpContext.Session.GetInt32("UserId") != null)
                return View();

            // We use GetUserByCredentialsAsync, beacause this method aleardy checks the password with BCrypt
            Models.User? user = await Models.User.GetUserByCredentialsAsync(userDAL, username, password);

            // Verify the password against the hashed version in DB
            if (user == null)
            {
                // if null, the username is null or BCrypt.Verify sent "False" in the DAL
                ViewData["Error"] = "The username or password is incorrect.";
                return View();
            }

            // If the program execute this lign, that means the password is correct.
            HttpContext.Session.SetInt32("UserId", user.Id);
            HttpContext.Session.SetString("Username", user.Username);

            string roleName = user switch
            {
                Customer => "Customer",
                Cashier => "Cashier",
                Preparer => "Preparer",
                _ => "Unknown"
            };
            HttpContext.Session.SetString("Role", roleName);

            // Since the method HttpContext waits an int and not a int? , I have to check the value of the shopId, and not the direct property.
            if (user is Cashier cashier && cashier.ShopId.HasValue)
            {
                HttpContext.Session.SetInt32("ShopId", cashier.ShopId.Value);
            }
            else if (user is Preparer preparer && preparer.ShopId.HasValue)
            {
                HttpContext.Session.SetInt32("ShopId", preparer.ShopId.Value);
            }

            // this just redirects the user to his correct view according to his role
            return user switch
            {
                Customer => RedirectToAction("Index", "Home"),
                Cashier => RedirectToAction("Index", "Cashier"),
                Preparer => RedirectToAction("Index", "Preparer"),
                _ => RedirectToAction("Index", "Home")
            };
        }

        public IActionResult Logout()
        {
            HttpContext.Session.Clear();
            return RedirectToAction("Index", "Home");
        }

        public IActionResult Register()
        {
            if (HttpContext.Session.GetInt32("UserId") != null)
            {
                string? userRole = HttpContext.Session.GetString("Role");

                if (userRole == "Preparer") return RedirectToAction("Index", "Preparer");
                if (userRole == "Cashier") return RedirectToAction("Index", "Cashier");

                return RedirectToAction("Index", "Home");
            }

            return View();
        }

        [HttpPost]
        public async Task<IActionResult> Register(Customer customer, Adress adress)
        {
            if (!ModelState.IsValid)
            {
                // Display all validation errors for debugging
                foreach (var error in ModelState.Values.SelectMany(v => v.Errors))
                {
                    Console.WriteLine(error.ErrorMessage);
                }
                return View(customer);
            }

            try
            {
                await adress.InitLonLatAsync();
            }
            catch (ArgumentException ex)
            {
                ViewData["Error"] = $" {ex.Message} | Try again !";
                return View(customer);
            }
            catch (Exception)
            {
                // the api is not available :'(
            }

            if (await Models.User.UsernameExistsAsync(userDAL, customer.Username))
            {
                ViewData["Error"] = "This username is already taken.";
                return View(customer);
            }


            await Models.User.RegisterCustomerAsync(userDAL, customer, adress);

            TempData["RegisterSuccess"] = "Account created successfully. You can now log in.";
            return RedirectToAction("Login");
        }
    }
}
