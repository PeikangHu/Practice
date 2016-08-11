using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ClothingForDocuSign.Domain.Commands
{
	public interface IClothingCommandRepository
	{
		IReadOnlyCollection<IClothingCommand> ClothingCommands { get; }

		IClothingCommand Get(int id);
	}
}
