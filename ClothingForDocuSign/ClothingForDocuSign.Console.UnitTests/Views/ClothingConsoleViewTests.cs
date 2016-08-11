using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Moq;
using ClothingForDocuSign.Views;
using ClothingForDocuSign.Domain;
using System.Collections.Generic;
using ClothingForDocuSign.Domain.Commands;

namespace ClothingForDocuSign.Console.UnitTests.Views
{
	[TestClass]
	public class ClothingConsoleViewTests
	{
		[TestMethod]
		[ExpectedException(typeof(ArgumentNullException))]
		public void Constructor_InputAndOutput_Can_Not_Be_NULL()
		{
			var clothingController = new Mock<IClothingController>();
			new ClothingConsoleView(null, clothingController.Object);
		}

		[TestMethod]
		[ExpectedException(typeof(ArgumentNullException))]
		public void Constructor_ClothingController_Can_Not_Be_NULL()
		{
			var inputAndOutput = new Mock<IInputAndOutput>();
			new ClothingConsoleView(inputAndOutput.Object, null);
		}

		[TestMethod]
		public void Can_Get_Right_Input_Hot()
		{
			// output string never changes, so it will show the tutorial. 
			// Otherwise, the tutorial will be override.
			Check_Input("HOT 8, 6, 4, 2, 1, 7",
						"Please type in the command like: HOT 8, 6, 4, 2, 1, 7 (Type in 'ESC' to exit the program)",
						TempratureType.HOT,
						"8,6,4,2,1,7");
		}

		[TestMethod]
		public void Can_Get_Right_Input_Cold()
		{
			// output string never changes, so it will show the tutorial. 
			// Otherwise, the tutorial will be override.
			Check_Input("COLD 8, 6, 4, 2, 1, 7",
						"Please type in the command like: HOT 8, 6, 4, 2, 1, 7 (Type in 'ESC' to exit the program)",
						TempratureType.COLD,
						"8,6,4,2,1,7");
		}

		[TestMethod]
		public void Can_Input_Lower_Letters()
		{
			// output string never changes, so it will show the tutorial. 
			// Otherwise, the tutorial will be override.
			Check_Input("colD 8, 6, 4, 2, 1, 7",
						"Please type in the command like: HOT 8, 6, 4, 2, 1, 7 (Type in 'ESC' to exit the program)",
						TempratureType.COLD,
						"8,6,4,2,1,7");
		}

		[TestMethod]
		public void Can_Input_Multiple_Blanks()
		{
			Check_Input("HOT      8,    6,    4,      2,   1,    7",
						"Please type in the command like: HOT 8, 6, 4, 2, 1, 7 (Type in 'ESC' to exit the program)",
						TempratureType.HOT,
						"8,6,4,2,1,7");
		}

		[TestMethod]
		public void Can_Output_Fail_When_Type_Is_Not_Right()
		{
			Check_Input("HO      8,    6,    4,      2,   1,    7",
						"fail\n",
						null,
						null);
		}

		[TestMethod]
		public void Can_Output_Fail_When_CommandIds_Are_Not_Numbers1()
		{
			Check_Input("HOT      8,    6,    4,   ,   1,    7",
						"fail\n",
						null,
						null);
		}

		[TestMethod]
		public void Can_Output_Fail_When_CommandIds_Are_Not_Numbers2()
		{
			Check_Input("HOT      8,    6,    4,  aaa ,   1,    7",
						"fail\n",
						null,
						null);
		}

		[TestMethod]
		public void Can_CommandEventListener_Add_Into_Final_Result()
		{
			// Arrange
			string outputActual = null;

			var inputAndOutputMock = new Mock<IInputAndOutput>();

			inputAndOutputMock.Setup(m =>
				m.Output(It.IsAny<string>()))
				.Callback<string>((output) =>
				{
					outputActual = output;
				});

			var clothingControllerMock = new Mock<IClothingController>();
			var clothingConsoleView = new ClothingConsoleView(inputAndOutputMock.Object, clothingControllerMock.Object);

			var clothingCommandMock = new Mock<IClothingCommand>();
			clothingCommandMock.Setup(m => m.Response(It.IsAny<TempratureType>())).Returns("Test");

			var eventArgs = new ClothingCommandEventArgs(clothingCommandMock.Object, true);

			// Act
			clothingConsoleView.CommandEventListener(eventArgs);
			clothingConsoleView.ShowResult();

			// Assert
			Assert.AreEqual(false, clothingConsoleView.IsFailed);
			Assert.AreEqual("Test\n", outputActual);
		}

		[TestMethod]
		public void Can_CommandEventListener_Success_Then_Fail()
		{
			// Arrange
			string outputActual = null;

			var inputAndOutputMock = new Mock<IInputAndOutput>();

			inputAndOutputMock.Setup(m =>
				m.Output(It.IsAny<string>()))
				.Callback<string>((output) =>
				{
					outputActual = output;
				});

			var clothingControllerMock = new Mock<IClothingController>();
			var clothingConsoleView = new ClothingConsoleView(inputAndOutputMock.Object, clothingControllerMock.Object);

			var clothingCommandMock = new Mock<IClothingCommand>();
			clothingCommandMock.Setup(m => m.Response(It.IsAny<TempratureType>())).Returns("Test");

			var eventArgs = new ClothingCommandEventArgs(clothingCommandMock.Object, true);
			var eventArgsFail = new ClothingCommandEventArgs(clothingCommandMock.Object, false);

			// Act
			clothingConsoleView.CommandEventListener(eventArgs);
			clothingConsoleView.CommandEventListener(eventArgsFail);
			clothingConsoleView.ShowResult();

			// Assert
			Assert.AreEqual(true, clothingConsoleView.IsFailed);
			Assert.AreEqual("Test, Fail\n", outputActual);
		}

		[TestMethod]
		public void Can_CommandEventListener_Fail()
		{
			// Arrange
			string outputActual = null;

			var inputAndOutputMock = new Mock<IInputAndOutput>();

			inputAndOutputMock.Setup(m =>
				m.Output(It.IsAny<string>()))
				.Callback<string>((output) =>
				{
					outputActual = output;
				});

			var clothingControllerMock = new Mock<IClothingController>();
			var clothingConsoleView = new ClothingConsoleView(inputAndOutputMock.Object, clothingControllerMock.Object);

			var clothingCommandMock = new Mock<IClothingCommand>();
			var eventArgs = new ClothingCommandEventArgs(clothingCommandMock.Object, false);

			// Act
			clothingConsoleView.CommandEventListener(eventArgs);
			clothingConsoleView.ShowResult();

			// Assert
			Assert.AreEqual(true, clothingConsoleView.IsFailed);
			Assert.AreEqual("fail\n", outputActual);
		}

		private void Check_Input(string input, string expectedOutput, TempratureType? expectedTempratureType, string expectedCommandIdStr)
		{
			// Arrange - IInputAndOutput
			string outputActual = null;

			var inputAndOutputMock = new Mock<IInputAndOutput>();

			inputAndOutputMock.Setup(m => m.InputValue).Returns(input);

			inputAndOutputMock.Setup(m =>
				m.Output(It.IsAny<string>()))
				.Callback<string>((output) =>
				{
					outputActual = output;
				});

			// Arrange - IClothingController
			TempratureType? tempratureTypeActual = null;
			IList<int> commandIdActual = null;

			var clothingControllerMock = new Mock<IClothingController>();
			clothingControllerMock.Setup(m =>
						m.OnInputFinished(It.IsAny<TempratureType?>(), It.IsAny<IList<int>>(), false))
						.Callback<TempratureType?, IList<int>, bool>((tempratureType, commandIds, exit) =>
						{
							tempratureTypeActual = tempratureType;
							commandIdActual = commandIds;
						});

			// Arrange - ClothingConsoleView
			var clothingConsoleView = new ClothingConsoleView(inputAndOutputMock.Object, clothingControllerMock.Object);
			
			// Act - ClothingConsoleView
			clothingConsoleView.WaitForInput();

			// Assert - HOT 8, 6, 4, 2, 1, 7
			Assert.AreEqual(expectedOutput, outputActual);
			Assert.AreEqual(expectedTempratureType, tempratureTypeActual);

			if (commandIdActual == null)
			{
				Assert.AreEqual(expectedCommandIdStr, commandIdActual);
			}
			else
			{
				Assert.AreEqual(expectedCommandIdStr, string.Join(",", commandIdActual));
			}
		}
	}
}
