using ClothingForDocuSign.Domain.Infrastructure.IdentityObject;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ClothingForDocuSign.Domain.Commands
{
	
	public interface IClothingCommand : IIdentityObject<int>
	{
		string Description { get; }
		string Response(TempratureType tempratureType);
	}
}
