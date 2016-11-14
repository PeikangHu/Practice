using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ASPCoreSportsStore.Models
{
	public class EFOrderRepository : IOrderRepository
	{
		private ApplicationDbContext context;

		public EFOrderRepository(ApplicationDbContext ctx)
		{
			context = ctx;
		}

		// Lines and product should be included.
		public IEnumerable<Order> Orders => context.Orders
												   .Include(o => o.Lines)
												   .ThenInclude(l => l.Product);

		public void SaveOrder(Order order)
		{
			// notify Entity Framework core that the objects exist and should not
			// be stored in the database unless they are modified.
			context.AttachRange(order.Lines.Select(l => l.Product));

			if (order.OrderID == 0)
			{
				context.Orders.Add(order);
			}

			context.SaveChanges();
		}
	}
}
