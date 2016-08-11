using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ClothingForDocuSign.Domain
{
	public enum TempratureType { HOT, COLD }

	// The standard even model requires a sender, but I do not want to expose the model to the view.
	public delegate void CommandRequest(ClothingCommandEventArgs eventArgs);

	public interface IClothingModel
	{
		event CommandRequest OnCommandRequest;
		
		void Next(int id);
		void Restart();
	}
}
