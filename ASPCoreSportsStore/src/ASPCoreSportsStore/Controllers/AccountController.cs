using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.AspNetCore.Authorization;
using ASPCoreSportsStore.Models.ViewModels;

// For more information on enabling MVC for empty projects, visit http://go.microsoft.com/fwlink/?LinkID=397860

namespace ASPCoreSportsStore.Controllers
{
	[Authorize]
    public class AccountController : Controller
    {
		private UserManager<IdentityUser> userManager;
		private SignInManager<IdentityUser> signInManager;

		public AccountController(UserManager<IdentityUser> userMgr, SignInManager<IdentityUser> signInMgr)
		{
			userManager = userMgr;
			signInManager = signInMgr;
		}

		[AllowAnonymous]
		public ViewResult Login(string returnUrl)
		{
			return View(new LoginModel{ ReturnUrl = returnUrl });
		}

		public IActionResult Index()
        {
            return View();
        }
    }
}
