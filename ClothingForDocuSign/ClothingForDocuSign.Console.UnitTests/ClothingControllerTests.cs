using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Moq;
using ClothingForDocuSign.Domain;
using ClothingForDocuSign.ConsoleView.Views;
using ClothingForDocuSign.Domain.Commands;
using ClothingForDocuSign.ConsoleView;
using ClothingForDocuSign.Views;
using System.Collections.Generic;

namespace ClothingForDocuSign.Console.UnitTests
{
	[TestClass]
	public class ClothingControllerTests
	{
		[TestMethod]
		[ExpectedException(typeof(ArgumentNullException))]
		public void Constructor_InputAndOutput_Can_Not_Be_NULL()
		{
			var clothingHotModelMock = new Mock<IClothingModel>();
			var clothingColdModelMock = new Mock<IClothingModel>();

			new ClothingController(null, clothingHotModelMock.Object, clothingColdModelMock.Object);
		}

		[TestMethod]
		[ExpectedException(typeof(ArgumentNullException))]
		public void Constructor_ClothingHotModel_Can_Not_Be_NULL()
		{
			var inputAndOutputMock = new Mock<IInputAndOutput>();
			var clothingColdModelMock = new Mock<IClothingModel>();

			new ClothingController(inputAndOutputMock.Object, null, clothingColdModelMock.Object);
		}

		[TestMethod]
		[ExpectedException(typeof(ArgumentNullException))]
		public void Constructor_ClothingColdModel_Can_Not_Be_NULL()
		{
			var inputAndOutputMock = new Mock<IInputAndOutput>();
			var clothingHotModelMock = new Mock<IClothingModel>();

			new ClothingController(inputAndOutputMock.Object, clothingHotModelMock.Object, null);
		}

		[TestMethod]
		public void Can_OnInputFinished_Exit()
		{
			// Arrange
			var inputAndOutputMock = new Mock<IInputAndOutput>();

			var clothingHotModelMock = new Mock<IClothingModel>();
			var clothingColdModelMock = new Mock<IClothingModel>();

			var controller = new ClothingController(inputAndOutputMock.Object, clothingHotModelMock.Object, clothingColdModelMock.Object);

			// Act
			controller.OnInputFinished(null, null, true);

			// Assert
			inputAndOutputMock.Verify(x => x.InputValue, Times.Never());
			inputAndOutputMock.Verify(x => x.Output(It.IsAny<string>()), Times.Never());
			clothingHotModelMock.Verify(x => x.Restart(), Times.Never());
			clothingColdModelMock.Verify(x => x.Restart(), Times.Never());
		}

		[TestMethod]
		public void Can_OnInputFinished_Null_Parameters()
		{
			// Arrange
			var inputAndOutputMock = new Mock<IInputAndOutput>();
			inputAndOutputMock.SetupSequence(m => m.InputValue).Returns("Test").Returns("ESC");

			var clothingHotModelMock = new Mock<IClothingModel>();
			var clothingColdModelMock = new Mock<IClothingModel>();

			var controller = new ClothingController(inputAndOutputMock.Object, clothingHotModelMock.Object, clothingColdModelMock.Object);

			// Act
			controller.OnInputFinished(null, null);


			// Assert
			inputAndOutputMock.Verify(x => x.InputValue, Times.Exactly(2));
			inputAndOutputMock.Verify(x => x.Output(It.IsAny<string>()), Times.Exactly(3));
			clothingHotModelMock.Verify(x => x.Restart(), Times.Never());
			clothingColdModelMock.Verify(x => x.Restart(), Times.Never());
		}

		[TestMethod]
		public void Can_OnInputFinished_Non_Null_Parameters()
		{
			// Arrange - IInputAndOutput
			var inputAndOutputMock = new Mock<IInputAndOutput>();
			inputAndOutputMock.Setup(m => m.InputValue).Returns("ESC");

			// Arrange - ClothingController
			var clothingHotModelMock = new Mock<IClothingModel>();
			var clothingColdModelMock = new Mock<IClothingModel>();

			var controller = new ClothingController(inputAndOutputMock.Object, clothingHotModelMock.Object, clothingColdModelMock.Object);

			// Act
			controller.OnInputFinished(TempratureType.HOT, new List<int>() { 8,6,4,2,1,7 });


			// Assert
			inputAndOutputMock.Verify(x => x.InputValue, Times.Exactly(1));
			inputAndOutputMock.Verify(x => x.Output(It.IsAny<string>()), Times.Exactly(2));
			clothingHotModelMock.Verify(x => x.Restart(), Times.Exactly(1));
			clothingColdModelMock.Verify(x => x.Restart(), Times.Never());
		}

	}
}
