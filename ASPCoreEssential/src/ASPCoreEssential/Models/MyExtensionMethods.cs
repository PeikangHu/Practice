using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ASPCoreEssential.Models
{
    public static class MyExtensionMethods
    {
		/*
		public static decimal TotalPrices(this ShoppingCart cartParam)
		{
			decimal total = 0;
			foreach (var prod in cartParam.Products)
			{
				total += prod?.Price ?? 0;
			}

			return total;
		}*/

		// I can calculate the total value of the Product objects enumerated by any IEnumerable<Product>,
		// which includes instances of ShoppingCart but also arrays of Product objects.

		/*
			Product[] productArray = 
			{
				new Product { Name = "aa", Price = 275M }
			} 

			productArray.TotalPrices();
		 */
		public static decimal TotalPrices(this IEnumerable<Product> products)
		{
			decimal total = 0;
			foreach (var prod in products)
			{
				total += prod?.Price ?? 0;
			}

			return total;
		}

		// Greating filtering extension methods.
		// productArray.FilterByPrice(20).TotalPrices();
		public static IEnumerable<Product> FilterByPrice(this IEnumerable<Product> productEnum, decimal minimumPrice)
		{
			foreach (var prod in productEnum)
			{
				if ((prod?.Price ?? 0) >= minimumPrice)
				{
					// to apply selection criteria to items in the source data to product a reduced set of results.
					yield return prod;
				}
			}
		}

		// More elegant approach
		public static IEnumerable<Product> Filter(
													this IEnumerable<Product> productEnum,
													Predicate<Product> selector)
		{
			foreach (var prod in productEnum)
			{
				if (selector(prod))
				{
					yield return prod;
				}
			}
		}
    }
}
