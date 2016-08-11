using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using ClothingForDocuSign.App_Start;
using ClothingForDocuSign.Domain;
using ClothingForDocuSign.Views;
using Ninject;
using ClothingForDocuSign.ConsoleView;
using Moq;
using System.Collections.Generic;

namespace ClothingForDocuSign.Console.UnitTests
{
	[TestClass]
	public class ProgramTests
	{
		/*
		Input: HOT 8, 6, 4, 2, 1, 7
		Output: Removing PJs, shorts, t-shirt, sun visor, sandals, leaving house

		Input: COLD 8, 6, 3, 4, 2, 5, 1, 7
		Output: Removing PJs, pants, socks, shirt, hat, jacket, boots, leaving house

		Input: HOT 8, 6, 6
		Output: Removing PJs, shorts, fail

		Input: HOT 8, 6, 3
		Output: Removing PJs, shorts, fail

		Input: COLD 8, 6, 3, 4, 2, 5, 7
		Output: Removing PJs, pants, socks, shirt, hat, jacket, fail

		Input: COLD 6
		Output: fail
		*/
		[TestMethod]
		public void Test_Scenarios()
		{
			// Arrange - IInputAndOutput
			var outputsActual = new List<string>();

			var inputAndOutputMock = new Mock<IInputAndOutput>();
			inputAndOutputMock.SetupSequence(m => m.InputValue).Returns("HOT 8, 6, 4, 2, 1, 7")
															   .Returns("COLD 8, 6, 3, 4, 2, 5, 1, 7")
															   .Returns("HOT 8, 6, 6")
															   .Returns("HOT 8, 6, 3")
															   .Returns("COLD 8, 6, 3, 4, 2, 5, 7")
															   .Returns("COLD 6")
															   .Returns("CO")
															   .Returns("HOT 8, 6, AA")
															   .Returns("ESC");

			inputAndOutputMock.Setup(m =>
				m.Output(It.IsAny<string>()))
				.Callback<string>((output) =>
				{
					outputsActual.Add(output);
				});

			// Arrange - ClothingController
			var clothingHotModel = NinjectSingleton.Instance.Kernel.Get<ClothingHotModel>();
			var clothingColdModel = NinjectSingleton.Instance.Kernel.Get<ClothingColdModel>();
			var inputAndOutput = inputAndOutputMock.Object;

			var controller = new ClothingController(inputAndOutput, clothingHotModel, clothingColdModel);
			controller.Start();

			// Assert - Index: 1, 3, 5, 7, 9, 11, 13, 15
			// please add "\n" to each result.
			Assert.AreEqual("Removing PJs, shorts, t-shirt, sun visor, sandals, leaving house\n", outputsActual[1]);
			Assert.AreEqual("Removing PJs, pants, socks, shirt, hat, jacket, boots, leaving house\n", outputsActual[3]);
			Assert.AreEqual("Removing PJs, shorts, fail\n", outputsActual[5]);
			Assert.AreEqual("Removing PJs, shorts, fail\n", outputsActual[7]);
			Assert.AreEqual("Removing PJs, pants, socks, shirt, hat, jacket, fail\n", outputsActual[9]);
			Assert.AreEqual("fail\n", outputsActual[11]);
			Assert.AreEqual("fail\n", outputsActual[13]);
			Assert.AreEqual("fail\n", outputsActual[15]);

			Assert.AreEqual(17, outputsActual.Count);
		}
	}
}
