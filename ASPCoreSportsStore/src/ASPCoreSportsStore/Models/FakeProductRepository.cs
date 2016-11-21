using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ASPCoreSportsStore.Models
{
    public class FakeProductRepository/*:IProductRepository (because I added the update one.) */
    {
		public IEnumerable<Product> Products => new List<Product>
		{
			new Product { Name = "Football", Price = 25 },
			new Product { Name = "Surfboard", Price = 179 },
			new Product { Name = "Running shoes", Price = 95 }
		};
    }
}
