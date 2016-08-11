using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using ClothingForDocuSign.Domain;
using ClothingForDocuSign.Domain.Commands;
using ClothingForDocuSign.Domain.Rules;
using Moq;
using ClothingForDocuSign.Domain.Infrastructure.ExecutionPlans;
using System.Collections.Generic;

namespace ClothingForDocuSign.UnitTests
{
	[TestClass]
	public class ClothingModelTests
	{
		public class MyClothingModelTests : ClothingModel
		{
			public MyClothingModelTests(IClothingCommandRepository clothingCommandRepository, IClothingRules clothingRules) : base(clothingCommandRepository, clothingRules)
			{
			}
		}

		[TestMethod]
		public void Constructor_Clothing_Cold_Model()
		{
			var clothingCommandRepositoryMock = new Mock<IClothingCommandRepository>();
			var clothingRulesMock = new Mock<IClothingRules>();
			var clothingModel = new ClothingColdModel(clothingCommandRepositoryMock.Object, clothingRulesMock.Object);
		}

		[TestMethod]
		public void Constructor_Clothing_Hot_Model()
		{
			var clothingCommandRepositoryMock = new Mock<IClothingCommandRepository>();
			var clothingRulesMock = new Mock<IClothingRules>();
			var clothingModel = new ClothingHotModel(clothingCommandRepositoryMock.Object, clothingRulesMock.Object);
		}

		[TestMethod]
		[ExpectedException(typeof(ArgumentNullException))]
		public void Constructor_ClothingCommandRepository_Can_Not_Be_Null()
		{
			var clothingRulesMock = new Mock<IClothingRules>();
			new MyClothingModelTests(null, clothingRulesMock.Object);
		}

		[TestMethod]
		[ExpectedException(typeof(ArgumentNullException))]
		public void Constructor_ClothingRules_Can_Not_Be_Null()
		{
			var clothingCommandRepositoryMock = new Mock<IClothingCommandRepository>();
			new MyClothingModelTests(clothingCommandRepositoryMock.Object, null);
		}

		[TestMethod]
		public void Can_Run()
		{
			// Arrange - ClothingCommands
			var clothingCommand1Mock = new Mock<IClothingCommand>();
			clothingCommand1Mock.Setup(m => m.ID).Returns(1);

			var clothingCommand2Mock = new Mock<IClothingCommand>();
			clothingCommand2Mock.Setup(m => m.ID).Returns(2);

			// Arrange - IClothingRules
			var clothingRulesMock = new Mock<IClothingRules>();
			clothingRulesMock.Setup(m => m.Rules.Run(It.IsAny<IClothingCommand>())).Returns(true);

			// Arrange - IClothingCommandRepository
			var clothingCommandRepositoryMock = new Mock<IClothingCommandRepository>();
			clothingCommandRepositoryMock.Setup(m => m.Get(1)).Returns(clothingCommand1Mock.Object);
			clothingCommandRepositoryMock.Setup(m => m.Get(2)).Returns(clothingCommand2Mock.Object);

			// Arrange - IClothingCommandRepository
			var clothingModel = new MyClothingModelTests(clothingCommandRepositoryMock.Object, clothingRulesMock.Object);

			// Arrange - OnCommandRequest
			bool? canContinue = null;
			IClothingCommand clothCommand = null;
			clothingModel.OnCommandRequest += delegate (ClothingCommandEventArgs eventArgs)
			{
				canContinue = eventArgs.CanContinue;
				clothCommand = eventArgs.Command;
			};

			// Act
			clothingModel.Next(1);

			// Assert
			Assert.AreEqual(true, canContinue.Value);
			Assert.AreEqual(1, clothCommand.ID);
		}

		[TestMethod]
		public void Can_Restart()
		{
			// Arrange
			var clothingCommandRepositoryMock = new Mock<IClothingCommandRepository>();
			var clothingRulesMock = new Mock<IClothingRules>();
			clothingRulesMock.Setup(m => m.Rules.Restart());

			var clothingModel = new ClothingColdModel(clothingCommandRepositoryMock.Object, clothingRulesMock.Object);

			// Act
			clothingModel.Restart();

			// Assert
			clothingRulesMock.Verify(x => x.Rules.Restart(), Times.Once());
		}

		[TestMethod]
		public void Can_Run_Send_Fail_When_No_This_Id()
		{
			// Arrange - IClothingRules
			var clothingRulesMock = new Mock<IClothingRules>();
			clothingRulesMock.Setup(m => m.Rules.Run(It.IsAny<IClothingCommand>())).Throws(new ArgumentOutOfRangeException());

			// Arrange - IClothingCommandRepository
			var clothingCommandRepositoryMock = new Mock<IClothingCommandRepository>();
			clothingCommandRepositoryMock.Setup(m => m.Get(It.IsAny<int>())).Throws(new ArgumentOutOfRangeException());

			// Arrange - IClothingCommandRepository
			var clothingModel = new MyClothingModelTests(clothingCommandRepositoryMock.Object, clothingRulesMock.Object);

			// Arrange - OnCommandRequest
			bool? canContinue = null;
			IClothingCommand clothCommand = null;
			clothingModel.OnCommandRequest += delegate (ClothingCommandEventArgs eventArgs)
			{
				canContinue = eventArgs.CanContinue;
				clothCommand = eventArgs.Command;
			};

			// Act
			clothingModel.Next(1);

			// Assert
			Assert.AreEqual(false, canContinue.Value);
			Assert.AreEqual(null, clothCommand);
		}
	}
}
