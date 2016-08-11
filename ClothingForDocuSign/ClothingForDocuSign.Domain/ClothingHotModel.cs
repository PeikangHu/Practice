using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using ClothingForDocuSign.Domain.Commands;
using ClothingForDocuSign.Domain.Rules;

namespace ClothingForDocuSign.Domain
{
	public class ClothingHotModel : ClothingModel
	{
		public ClothingHotModel(IClothingCommandRepository clothingCommandRepository, IClothingRules clothingRules) : base(clothingCommandRepository, clothingRules)
		{
		}
	}
}
