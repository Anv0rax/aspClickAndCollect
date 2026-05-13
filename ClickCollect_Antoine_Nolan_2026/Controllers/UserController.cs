using ClickCollect_Antoine_Nolan_2026.DAL;
using Microsoft.AspNetCore.Mvc;
using ClickCollect_Antoine_Nolan_2026.Models;
using BCrypt.Net;

namespace ClickCollect_Antoine_Nolan_2026.Controllers
{
    public class UserController : Controller
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
            // Retrieve user by username only
            User? user = await userDAL.GetUserByUsernameAsync(username);

            // Verify the password against the hashed version in DB
            if (user == null || !BCrypt.Net.BCrypt.Verify(password, user.Password))
            {
                ViewData["Error"] = "The username or password is incorrect.";
                return View();
            }

            HttpContext.Session.SetInt32("UserId", user.Id);

            if (user is Customer)
                return RedirectToAction("Index", "Home");
            else if (user is Cashier)
                return RedirectToAction("Index", "Cashier");
            else if (user is Preparer)
                return RedirectToAction("Index", "Preparer");

            return RedirectToAction("Index", "Home");
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
            catch (Exception ex)
            {
                ViewData["Error"] = $" {ex.Message} | The address you put into the fields is not correct. Try again !";
                return View(customer);
            }

            if (await userDAL.UsernameExistsAsync(customer.Username))
            {
                ViewData["Error"] = "This username is already taken.";
                return View(customer);
            }

            customer.Password = BCrypt.Net.BCrypt.HashPassword(customer.Password);

            await userDAL.RegisterCustomerAsync(customer, adress);

            TempData["RegisterSuccess"] = "Account created successfully. You can now log in.";
            return RedirectToAction("Login");
        }
    }
}
