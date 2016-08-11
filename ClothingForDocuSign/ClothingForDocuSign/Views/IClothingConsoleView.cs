using ClothingForDocuSign.Domain;
using ClothingForDocuSign.Domain.Commands;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ClothingForDocuSign.ConsoleView.Views
{
	public interface IClothingConsoleView
	{
		void CommandEventListener(ClothingCommandEventArgs eventArgs);
		bool IsFailed { get; }

		void ShowResult();

		void WaitForInput();
	}
}
