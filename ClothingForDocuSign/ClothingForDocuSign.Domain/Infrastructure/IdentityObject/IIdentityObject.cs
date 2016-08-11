using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ClothingForDocuSign.Domain.Infrastructure.IdentityObject
{
	public interface IIdentityObject<T>
	{
		T ID { get; }
	}
}
