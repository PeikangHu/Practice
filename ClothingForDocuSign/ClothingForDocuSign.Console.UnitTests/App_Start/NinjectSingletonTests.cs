using ClothingForDocuSign.App_Start;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ClothingForDocuSign.Console.UnitTests.App_Start
{
	[TestClass]
	public class NinjectSingletonTests
	{
		[TestMethod]
		public void Can_Get_Kernel()
		{
			Assert.IsNotNull(NinjectSingleton.Instance.Kernel);
		}
	}
}
