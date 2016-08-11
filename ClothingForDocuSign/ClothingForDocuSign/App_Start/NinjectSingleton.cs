using ClothingForDocuSign.ConsoleView.App_Start;
using Ninject;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ClothingForDocuSign.App_Start
{
	public sealed class NinjectSingleton
	{
		private static readonly Lazy<NinjectSingleton> lazy = new Lazy<NinjectSingleton>(() => new NinjectSingleton());

		private StandardKernel _kernel;

		public StandardKernel Kernel { get { return _kernel; } }

		public static NinjectSingleton Instance { get { return lazy.Value; } }

		private NinjectSingleton()
		{
			_kernel = new StandardKernel(new NinjectBindings());
		}
	}
}
