using ClothingForDocuSign.Domain.Commands;
using ClothingForDocuSign.Domain.Rules;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ClothingForDocuSign.Domain
{
	
	public abstract class ClothingModel : IClothingModel
	{
		public event CommandRequest OnCommandRequest;

		private readonly IClothingCommandRepository _clothingCommandRepository;
		private readonly IClothingRules _clothingRules;

		public ClothingModel(IClothingCommandRepository clothingCommandRepository, IClothingRules clothingRules)
		{
			if (clothingCommandRepository == null || clothingRules == null)
				throw new ArgumentNullException("ClothingCommandRepository and clothingRules should not be NULL.");

			//var clothingRules = GetClothingRules();

			_clothingRules = clothingRules;
			_clothingCommandRepository = clothingCommandRepository;
		}

		//abstract protected IClothingRules GetClothingRules(); 

		public void Next(int id)
		{
			try
			{
				var curCommand = _clothingCommandRepository.Get(id);
				var canContinue = _clothingRules.Rules.Run(curCommand);

				OnCommandRequest(new ClothingCommandEventArgs(curCommand, canContinue));
			}
			catch (Exception)
			{
				OnCommandRequest(new ClothingCommandEventArgs(null, false));
			}
		}

		public void Restart()
		{
			_clothingRules.Rules.Restart();
		}
	}

	public class ClothingCommandEventArgs : EventArgs
	{
		private IClothingCommand _command;
		private bool _canContinue;
		public IClothingCommand Command { get { return _command; } }
		public bool CanContinue { get { return _canContinue;  } }

		public ClothingCommandEventArgs(IClothingCommand command, bool canContinue)
		{
			_command = command;
			_canContinue = canContinue;
		}

	}
}
