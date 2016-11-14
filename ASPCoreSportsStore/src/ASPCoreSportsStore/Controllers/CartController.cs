using System;
using System.Collections.Generic;
using System.Linq;
using Microsoft.AspNetCore.Http;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using ASPCoreSportsStore.Models;
using ASPCoreSportsStore.Infrastructure;
using ASPCoreSportsStore.Models.ViewModels;

// For more information on enabling MVC for empty projects, visit http://go.microsoft.com/fwlink/?LinkID=397860

namespace ASPCoreSportsStore.Controllers
{
    public class CartController : Controller
    {
		private IProductRepository repository;

		// By using dependency injection, so it will use SessionCart
		private Cart cart;

		
		public CartController(IProductRepository repo, Cart cartService)
		{
			repository = repo;
			cart = cartService;
		}

		public ViewResult Index(string returnUrl)
		{
			return View(new CartIndexViewModel
							{
								Cart = cart,
								ReturnUrl = returnUrl
							});
		}

		public RedirectToActionResult AddToCart(int productId, string returnUrl)
		{
			var product = repository.Products.FirstOrDefault(p => p.ProductID == productId);

			if (product != null)
			{
				cart.AddItem(product, 1);
			}

			return RedirectToAction("Index", new { returnUrl });
		}

		public RedirectToActionResult RemoveFromCart(int productId, string returnUrl)
		{
			var product = repository.Products.FirstOrDefault(p => p.ProductID == productId);

			if (product != null)
			{
				cart.RemoveLine(product);
			}

			return RedirectToAction("Index", new { returnUrl });
		}
    }
}
