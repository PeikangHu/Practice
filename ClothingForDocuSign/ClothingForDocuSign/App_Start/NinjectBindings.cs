using ClothingForDocuSign.ConsoleView.Views;
using ClothingForDocuSign.Domain;
using ClothingForDocuSign.Domain.Commands;
using ClothingForDocuSign.Domain.Rules;
using ClothingForDocuSign.Views;
using Ninject.Modules;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ClothingForDocuSign.ConsoleView.App_Start
{
	public class NinjectBindings : NinjectModule
	{
		public override void Load()
		{
			Bind<IInputAndOutput>().To<ConsoleInputAndOutput>();
			Bind<IClothingCommandRepository>().To<MemoryClothingCommandRepository>().InSingletonScope();
			Bind<IClothingRules>().To<ClothingHotRules>().WhenInjectedInto<ClothingHotModel>().InSingletonScope();
			Bind<IClothingRules>().To<ClothingColdRules>().WhenInjectedInto<ClothingColdModel>().InSingletonScope();
		}
	}
}
