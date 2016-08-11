using ClothingForDocuSign.Domain.Commands;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using ClothingForDocuSign.Domain.Rules;

namespace ClothingForDocuSign.Domain
{
	public class ClothingColdModel : ClothingModel
	{
		public ClothingColdModel(IClothingCommandRepository clothingCommandRepository, IClothingRules clothingRules) : base(clothingCommandRepository, clothingRules)
		{
		}
	}
}
