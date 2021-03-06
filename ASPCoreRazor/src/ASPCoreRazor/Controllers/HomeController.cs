﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using ASPCoreRazor.Models;

// For more information on enabling MVC for empty projects, visit http://go.microsoft.com/fwlink/?LinkID=397860

namespace ASPCoreRazor.Controllers
{
    public class HomeController : Controller
    {
        public ViewResult Index()
        {
			var myProduct = new Product
			{
				ProductID = 1,
				Name = "Kayak",
				Description = "A boat for one person",
				Category = "Watersports",
				Price = 275M
			};

			ViewBag.StockLevel = 2;
			return View(myProduct);
        }

		public IActionResult ProductList()
		{
			Product[] array =
				{
					new Product { Name = "Kayak", Price = 275M },
					new Product { Name = "Lifejacket", Price = 48.95M },
					new Product { Name = "Soccer ball", Price = 19.50M },
					new Product { Name = "Corner flag", Price = 34.95M }
				};
			return View(array);
		}
    }
}
