using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ClothingForDocuSign.Views
{
	public class ConsoleInputAndOutput : IInputAndOutput
	{
		public string InputValue
		{
			get
			{
				return Console.ReadLine();
			}
		}

		public void Output(string value)
		{
			Console.WriteLine(value);
		}
	}
}
