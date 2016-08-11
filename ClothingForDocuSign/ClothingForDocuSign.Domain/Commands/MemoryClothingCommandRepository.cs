using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ClothingForDocuSign.Domain.Commands
{
	public class MemoryClothingCommandRepository : IClothingCommandRepository
	{
		private Dictionary<int, IClothingCommand> _idAndclothingCommand;
		private List<IClothingCommand> _clothingCommands;

		public MemoryClothingCommandRepository()
		{
			_clothingCommands = new List<IClothingCommand>()
				{
					new ClothingCommand(1, "Put on footwear", "sandals", "boots"),
					new ClothingCommand(2, "Put on headwear", "sun visor", "hat"),
					new ClothingCommand(3, "Put on socks", null, "socks"),
					new ClothingCommand(4, "Put on shirt", "t-shirt", "shirt"),
					new ClothingCommand(5, "Put on jacket", null, "jacket"),
					new ClothingCommand(6, "Put on pants", "shorts", "pants"),
					new ClothingCommand(7, "Leave house", "leaving house"),
					new ClothingCommand(8, "Take off pajamas", "Removing PJs")
				};


			_idAndclothingCommand = new Dictionary<int, IClothingCommand>();

			foreach (var clothingCommand in ClothingCommands)
			{
				_idAndclothingCommand[clothingCommand.ID] = clothingCommand;
			}
		}
		public IReadOnlyCollection<IClothingCommand> ClothingCommands
		{
			get
			{
				return new ReadOnlyCollection<IClothingCommand>(_clothingCommands);
			}
		}

		public IClothingCommand Get(int id)
		{
			if (!_idAndclothingCommand.ContainsKey(id))
				throw new ArgumentOutOfRangeException($"It does not contain a command with id: {id}");

			return _idAndclothingCommand[id];
		}
	}
}
