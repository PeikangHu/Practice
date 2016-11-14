using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Logging;
using ASPCoreSportsStore.Models;
using Microsoft.Extensions.Configuration;
using Microsoft.EntityFrameworkCore;

namespace ASPCoreSportsStore
{
    public class Startup
    {
		IConfigurationRoot Configuration;

		public Startup(IHostingEnvironment env)
		{
			Configuration = new ConfigurationBuilder()
								.SetBasePath(env.ContentRootPath)
								.AddJsonFile("appsettings.json")
								.Build();
		}

        // This method gets called by the runtime. Use this method to add services to the container.
        // For more information on how to configure your application, visit http://go.microsoft.com/fwlink/?LinkID=398940
        public void ConfigureServices(IServiceCollection services)
        {
			services.AddDbContext<ApplicationDbContext>(options => 
								options.UseSqlServer(Configuration["ConnectionStrings:DefaultConnection"]));

			services.AddTransient<IProductRepository, EFProductRepository>();

			// The same object should be used to satisfy related requests for Cart instances.
			// Rather than provide the AddScoped method with a type mapping, as I did for the repository.
			// The lambda expression receives the collection of services that have been registered and passes the collection to the GetCart method of the SessionCart class.
			services.AddScoped(sp => SessionCart.GetCart(sp));
			services.AddSingleton<IHttpContextAccessor, HttpContextAccessor>();

			services.AddTransient<IOrderRepository, EFOrderRepository>();

			services.AddMvc();
			services.AddMemoryCache();
			services.AddSession();
        }

        // This method gets called by the ru ntime. Use this method to configure the HTTP request pipeline.
        public void Configure(IApplicationBuilder app, IHostingEnvironment env, ILoggerFactory loggerFactory)
        {
            loggerFactory.AddConsole();

            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
            }

			app.UseStatusCodePages();
			app.UseStaticFiles();
			app.UseSession();
			//app.UseMvcWithDefaultRoute();

			app.UseMvc(routes => {
				routes.MapRoute(
					name:null,
					template: "{category}/Page{page:int}",
					defaults: new { controller = "Product", action="List"}
					);
				routes.MapRoute(
					name:null,
					template: "Page{page:int}",
					defaults: new { Controller = "Product", action = "List", page = 1 }
					);
				routes.MapRoute(
					name: null,
					template: "{category}",
					defaults: new { Controller = "Product", action = "List", page = 1 }
					);
				routes.MapRoute(
					name: null,
					template: "",
					defaults: new { Controller = "Product", action = "List", page = 1 });
				routes.MapRoute(
					name: null, 
					template: "{controller}/{action}/{id?}");
					});

			// can run seeddata first.
			SeedData.EnsurePopulated(app);
        }
    }
}
