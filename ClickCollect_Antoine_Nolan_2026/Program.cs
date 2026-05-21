using ClickCollect_Antoine_Nolan_2026.DAL;

namespace ClickCollect_Antoine_Nolan_2026
{
    public class Program
    {
        public static void Main(string[] args)
        {
            var builder = WebApplication.CreateBuilder(args);

            // Add services to the container.
            builder.Services.AddControllersWithViews();

            // To configure the session, we need to addSession.

            builder.Services.AddSession(options =>
            {
                options.IdleTimeout = TimeSpan.FromMinutes(45);
                options.Cookie.HttpOnly = true;
                options.Cookie.IsEssential = true;
            });

            string? connectionString = builder.Configuration.GetConnectionString("default");
            builder.Services.AddTransient<IUserDAL>(u => new UserDAL(connectionString!));
            builder.Services.AddTransient<IProductDAL>(p => new ProductDAL(connectionString!));
            builder.Services.AddTransient<IShopDAL>(s => new ShopDAL(connectionString!));
            builder.Services.AddTransient<IOrderDAL>(t => new OrderDAL(connectionString!));
            builder.Services.AddTransient<IRecipeDAL>(r => new RecipeDAL(connectionString!));

            var app = builder.Build();

            // Configure the HTTP request pipeline.
            if (!app.Environment.IsDevelopment())
            {
                app.UseExceptionHandler("/Home/Error");
                // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
                app.UseHsts();
            }

            app.UseHttpsRedirection();
            app.UseStaticFiles();

            app.UseRouting();

            app.UseSession();

            app.UseAuthorization();

            //app.MapControllerRoute(
            //    name: "viewProduct",
            //    pattern: "product/{productId:alpha:maxlength(12)}",
            //    defaults: new { controller = "Product", action = "ViewProduct" }
            //    );

            app.MapControllerRoute(
                name: "default",
                pattern: "{controller=Home}/{action=Index}/{id?}");

            app.Run();
        }
    }
}
