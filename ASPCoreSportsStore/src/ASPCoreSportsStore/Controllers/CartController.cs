using System;
using System.Collections.Generic;
using System.Linq;
using Microsoft.AspNetCore.Http;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using ASPCoreSportsStore.Models;
using ASPCoreSportsStore.Infrastructure;

// For more information on enabling MVC for empty projects, visit http://go.microsoft.com/fwlink/?LinkID=397860

namespace ASPCoreSportsStore.Controllers
{
    public class CartController : Controller
    {
		private IProductRepository repository;

		public CartController(IProductRepository repo)
		{
			repository = repo;
		}

		public RedirectToActionResult AddToCart(int productId, string returnUrl)
		{
			var product = repository.Products.FirstOrDefault(p => p.ProductID == productId);

			if (product != null)
			{
				var cart = GetCart();
				cart.AddItem(product, 1);
				SaveCart(cart);
			}

			return RedirectToAction("Index", new { returnUrl });
		}

		public RedirectToActionResult RemoveFromCart(int productId, string returnUrl)
		{
			var product = repository.Products.FirstOrDefault(p => p.ProductID == productId);

			if (product != null)
			{
				var cart = GetCart();
				cart.RemoveLine(product);
				SaveCart(cart);
			}

			return RedirectToAction("Index", new { returnUrl  });
		}

		private Cart GetCart()
		{
			var cart = HttpContext.Session.GetJson<Cart>("Cart") ?? new Cart();
			return cart;
		}

		private void SaveCart(Cart cart)
		{
			HttpContext.Session.setJson("Cart", cart);
		}
    }
}
