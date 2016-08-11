using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ClothingForDocuSign.Views
{
	public interface IInputAndOutput
	{
		string InputValue { get; }
		void Output(string value);
	}
}
