using ClothingForDocuSign.App_Start;
using ClothingForDocuSign.ConsoleView.Views;
using ClothingForDocuSign.Domain;
using ClothingForDocuSign.Domain.Commands;
using ClothingForDocuSign.Domain.Rules;
using System;
using System.Collections.Generic;
using Ninject;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using ClothingForDocuSign.Views;

namespace ClothingForDocuSign.ConsoleView
{
	public class ClothingController : IClothingController
	{
		private IClothingModel _clothingModel;
		private IClothingModel _clothingHotModel;
		private IClothingModel _clothingColdModel;

		private IClothingConsoleView _clothingConsoleView;

		private CommandRequest _commandRequest;

		public ClothingController(IInputAndOutput inputAndOutput, IClothingModel clothingHotModel, IClothingModel clothingColdModel)
		{
			if (inputAndOutput == null || clothingHotModel == null || clothingColdModel == null)
				throw new ArgumentNullException("InputAndOutput, clothingHotModel and clothingColdModel should not be NULL.");

			_clothingConsoleView = new ClothingConsoleView(inputAndOutput, this);
			
			_commandRequest = new CommandRequest(_clothingConsoleView.CommandEventListener);

			_clothingModel = null;
			_clothingHotModel = clothingHotModel;
			_clothingColdModel = clothingColdModel;
		}

		public void OnInputFinished(TempratureType? tempratureType, IList<int> commandIds, bool exit = false)
		{
			if (exit) return;

			if (tempratureType == null || commandIds == null)
			{
				Start();
				return;
			}

			_clothingModel = GetClothingModel(tempratureType.Value);

			foreach (var commandId in commandIds)
			{
				if (!_clothingConsoleView.IsFailed)
					_clothingModel.Next(commandId);
				else
					break;
			}

			_clothingConsoleView.ShowResult();

			Start();
		}

		private IClothingModel GetClothingModel(TempratureType tempratureType)
		{
			var model = _clothingColdModel;

			if (tempratureType == TempratureType.HOT)	model = _clothingHotModel;

			// ClothingConsoleView will listen ClothingModel. 
			model.OnCommandRequest += _commandRequest;
			return model;
		}

		public void Start()
		{
			if (_clothingModel != null)
			{
				_clothingModel.OnCommandRequest -= _commandRequest;
				_clothingModel.Restart();
			}
			_clothingModel = null;
			_clothingConsoleView.WaitForInput();
		}
	}
}
