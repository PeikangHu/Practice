using ClothingForDocuSign.ConsoleView;
using ClothingForDocuSign.ConsoleView.Views;
using ClothingForDocuSign.Domain;
using ClothingForDocuSign.Domain.Commands;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ClothingForDocuSign.Views
{
	public class ClothingConsoleView : IClothingConsoleView
	{
		private const string tutorial = "Please type in the command like: HOT 8, 6, 4, 2, 1, 7 (Type in 'ESC' to exit the program)";
		private const string Failure = "fail";
		private const string ExitCommand = "ESC";

		private readonly IInputAndOutput _inputAndOutput;
		private readonly IClothingController _clothingController;

		private bool _isFailed;
		private IList<string> _clothingCommandResult;

		private TempratureType _tempratureType;

		public ClothingConsoleView(IInputAndOutput inputAndOutput, IClothingController clothingController)
		{
			if (inputAndOutput == null || clothingController == null)
				throw new ArgumentNullException("InputAndOutput and clothingController could not be NULL.");

			_clothingController = clothingController;

			_inputAndOutput = inputAndOutput;

			_clothingCommandResult = new List<string>();
			_isFailed = false;
		}

		public void WaitForInput()
		{
			Init();

			_inputAndOutput.Output(tutorial);
			// listening the input
			var input = _inputAndOutput.InputValue;

			if (input.ToUpper() == ExitCommand)
			{
				OnInputFinished(null, null, true);
				return;
			}

			try
			{
				var tempratureType = GetTempratureType(input);
				var clothingCommands = GetCommandIdList(input);
				OnInputFinished(tempratureType, clothingCommands);
			}
			catch (Exception)
			{
				// TODO: This part can output "The format is wrong."
				_inputAndOutput.Output("fail\n");
				OnInputFinished(null, null);
			}
		}

		private void Init()
		{
			_clothingCommandResult.Clear();
			_isFailed = false;
		}

		private void OnInputFinished(TempratureType? tempratureType, IList<int> commandIds, bool exit = false)
		{
			if (tempratureType != null && commandIds != null)	_tempratureType = tempratureType.Value;

			_clothingController.OnInputFinished(tempratureType, commandIds, exit);
		}

		public bool IsFailed { get { return _isFailed; } }

		public void CommandEventListener(ClothingCommandEventArgs eventArgs)
		{
			if (!eventArgs.CanContinue)
			{
				Fail();
			}
			else
			{
				_clothingCommandResult.Add(eventArgs.Command.Response(_tempratureType));
			}
		}

		public void ShowResult()
		{
			_inputAndOutput.Output($"{string.Join(", ", _clothingCommandResult)}\n" );
		}

		private void Fail()
		{
			_isFailed = true;
			_clothingCommandResult.Add(Failure);
		}

		private IList<int> GetCommandIdList(string input)
		{
			if (input == null || input == "") throw new ArgumentNullException("Input should not be NULL");

			var result = new List<int>();

			int? startIndex = null;

			for (int i = 0; i < input.Length; i++)
			{
				if ('0' <= input[i] && input[i] <= '9')
				{
					startIndex = i;
					break;
				}
			}

			var commandListString = input.Substring(startIndex.Value);

			foreach (var commandIdStr in commandListString.Split(','))
			{
				int commandId = int.Parse(commandIdStr);
				result.Add(commandId);
			}

			return result;
		}

		private TempratureType GetTempratureType(string input)
		{
			if (input == null || input == "") throw new ArgumentNullException("Input should not be NULL");

			int? startIndex = null;
			int length = 1;
			for (int i = 0; i < input.Length; i++)
			{
				if (input[i] != ' ' && startIndex == null) startIndex = i;
				else if (input[i] == ' ' && startIndex != null) break;
				else length++;
			}

			var tempratureString = input.Substring(startIndex.Value, length).ToUpper();

			if (tempratureString == "HOT")
			{
				return TempratureType.HOT;
			}
			else if (tempratureString == "COLD")
			{
				return TempratureType.COLD;
			}
			else
			{
				throw new ArgumentOutOfRangeException($"Input could only be 'HOT' or 'COLD'. Input: {input}");
			}
		}
	}
}
