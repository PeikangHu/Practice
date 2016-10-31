using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using ASPCoreEssential.Models;

// For more information on enabling MVC for empty projects, visit http://go.microsoft.com/fwlink/?LinkID=397860

namespace ASPCoreEssential.Controllers
{
    public class HomeController : Controller
    {
		public async Task<ViewResult> Index3()
		{
			long? length = await MyAsyncMethods.GetPageLength1();
			return View(new string[] { $"Length: {length}" });
		}

		public ViewResult Index2()
		{
			// using anonymous types
			var products = new[] { new { Name = "Kayak", Price = 275M } };

			// "nameof" produces a name string.
			return View(products.Select(p => $"{nameof(p.Name)}:{p.Name}, {nameof(p.Price)}:{p.Price}"));
		}

		public ViewResult Index1() => View(Product.GetProducts().Select(p => p?.Name));

        public ViewResult Index()
        {
			// Using extension methods
			var cart = new ShoppingCart { Products = Product.GetProducts() };
			var cartTotal = cart.TotalPrices();

			//return View("Index", new string[] { $"Total: { cartTotal:C2}" });

			// Using an index initializer
			Dictionary<string, Product> products = new Dictionary<string, Product>
			{
				["Kayak"] = new Product { Name = "Kayak", Price = 275M },
				["Lifejacket"] = new Product { Name = "Lifejacket", Price=48.95M }
			};

			//return View("Index", products.Keys);

			List<string> results = new List<string>();

			foreach (Product p in Product.GetProducts())
			{
				string name = p?.Name ?? "<No Name>";
				decimal? price = p?.Price ?? 0;

				// Chaining the null conditional operator
				string relatedName = p?.Related?.Name ?? "<None>";

				// using string interpolation (price:C2)
				results.Add($"Name: {name}, Price: {price:C2}, Related: {relatedName}");
			}

			return View(results);
        }

		public ViewResult Filter()
		{
			Product[] productArray =
			{
				new Product { Name = "aa", Price = 275M },
				new Product { Name = "S", Price = 19.98M }
			};

			Predicate<Product> nameFilter = delegate (Product prod)
			{
				return prod?.Name?[0] == 'S';
			};

			decimal priceFilterTotal = productArray.Filter(nameFilter).TotalPrices();

			productArray.Filter(p => p?.Name?[0] == 'S').TotalPrices();

			return View("Index", new string[] { $"{priceFilterTotal}" });
		}
	}
}
