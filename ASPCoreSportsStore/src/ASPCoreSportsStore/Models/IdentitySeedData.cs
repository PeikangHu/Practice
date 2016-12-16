using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.Extensions.DependencyInjection;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ASPCoreSportsStore.Models
{
    public static class IdentitySeedData
    {
		private const string adminUser = "Admin";
		private const string adminPasssword = "Secret123$";

		public static async void EnsurePopulated(IApplicationBuilder app)
		{
			var userManager = app.ApplicationServices.GetRequiredService<UserManager<IdentityUser>>();

			var user = await userManager.FindByIdAsync(adminUser);

			if (user == null)
			{
				user = new IdentityUser("Admin");
				await userManager.CreateAsync(user, adminPasssword);
			}
		}
    }
}
