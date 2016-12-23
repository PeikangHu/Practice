using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using ASPCoreSportsStore.Models;
using Microsoft.AspNetCore.Authorization;

// For more information on enabling MVC for empty projects, visit http://go.microsoft.com/fwlink/?LinkID=397860

namespace ASPCoreSportsStore.Controllers
{
	[Authorize]
    public class AdminController : Controller
    {
		private IProductRepository repository;

		public AdminController(IProductRepository repo)
		{
			repository = repo;
		}

		public ViewResult Index() => View(repository.Products);

		public ViewResult Edit(int productId) => 
						View(repository.Products
							.FirstOrDefault(p => p.ProductID == productId));

		[HttpPost]
		public IActionResult Edit(Product product)
		{
			if (ModelState.IsValid)
			{
				repository.SaveProduct(product);
				// It can be deleted when it is read.
				TempData["message"] = $"{product.Name} has been saved.";
				return RedirectToAction("Index");
			}
			else
			{
				// there is something wrong with the data values
				return View(product);
			}
		}

		public ViewResult Create() => View("Edit", new Product());

		[HttpPost]
		public IActionResult Delete(int productId)
		{
			var deletedProduct = repository.DeleteProduct(productId);
			if (deletedProduct != null)
			{
				TempData["message"] = $"{deletedProduct.Name} was deleted";
			}

			return RedirectToAction("Index");
		}
    }

}
