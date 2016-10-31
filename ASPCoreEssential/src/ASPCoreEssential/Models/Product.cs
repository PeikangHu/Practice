using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ASPCoreEssential.Models
{
    public class Product
    {
		public string Name { get; set; }

		// auto-implemented property initializers.
		public string Category { get; set; } = "Watersports";
		public decimal? Price { get; set; }
		public Product Related { get; set; }

		// read-only automatically implemented properties.
		public bool InStock { get; } = true;

		// a property that uses a lambda express
		public bool NameBeginsWithS => Name?[0] == 'S';

		public Product(bool stock = true)
		{
			InStock = stock;
		}

		public static Product[] GetProducts()
		{
			Product kayak = new Product
			{
				Name = "Kayak",
				Price = 275000M,
				Category = "Water Craft"
			};

			Product lifejacket = new Product(false)
			{
				Name = "Lifejacket",
				Price = 48.95M
			};

			kayak.Related = lifejacket;

			return new Product[] { kayak, lifejacket, null };
		}
    }
}
