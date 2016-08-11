using ClothingForDocuSign.App_Start;
using ClothingForDocuSign.ConsoleView.App_Start;
using ClothingForDocuSign.ConsoleView.Views;
using ClothingForDocuSign.Domain;
using ClothingForDocuSign.Views;
using Ninject;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;

namespace ClothingForDocuSign.ConsoleView
{
	class Program
	{
		static void Main(string[] args)
		{
			var clothingHotModel = NinjectSingleton.Instance.Kernel.Get<ClothingHotModel>();
			var clothingColdModel = NinjectSingleton.Instance.Kernel.Get<ClothingColdModel>();
			var inputAndOutput = NinjectSingleton.Instance.Kernel.Get<IInputAndOutput>();

			var controller = new ClothingController(inputAndOutput, clothingHotModel, clothingColdModel);
			controller.Start();
		}
	}
}
