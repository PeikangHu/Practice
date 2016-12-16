using Microsoft.EntityFrameworkCore.Infrastructure;
using Microsoft.Extensions.Configuration;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ASPCoreSportsStore.Models
{
    public class AppIdentityDbContextFactory : IDbContextFactory<AppIdentityDbContext>
	{
		IConfigurationRoot Configuration;

		public AppIdentityDbContextFactory()
		{

		}

		public AppIdentityDbContext Create(DbContextFactoryOptions options)
		{
			//throw new NotImplementedException();
			return null;
		}
	}
}
