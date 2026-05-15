using ClickCollect_Antoine_Nolan_2026.DAL;
using Microsoft.AspNetCore.Mvc;
using ClickCollect_Antoine_Nolan_2026.Models;
using BCrypt.Net;

namespace ClickCollect_Antoine_Nolan_2026.Controllers
{
    public class UserController : BaseController
    {
        private readonly IUserDAL userDAL;

        public UserController(IUserDAL userDAL)
        {
            this.userDAL = userDAL;
        }

        public IActionResult Login()
        {
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

            // We use GetUserByCredentialsAsync, beacause this method aleardy checks the password with BCrypt
            User? user = await userDAL.GetUserByCredentialsAsync(username, password);

            // Verify the password against the hashed version in DB
            if (user == null)
            {
                // if null, the username is null or BCrypt.Verify sent "False" in the DAL
                ViewData["Error"] = "The username or password is incorrect.";
                return View();
            }

            // If the program execute this lign, that means the password is correct.
            HttpContext.Session.SetInt32("UserId", user.Id);

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
            catch (Exception ex)
            {
                // the api is not available :'(
            }

            if (await userDAL.UsernameExistsAsync(customer.Username))
            {
                ViewData["Error"] = "This username is already taken.";
                return View(customer);
            }


            await userDAL.RegisterCustomerAsync(customer, adress);

            TempData["RegisterSuccess"] = "Account created successfully. You can now log in.";
            return RedirectToAction("Login");
        }
    }
}
