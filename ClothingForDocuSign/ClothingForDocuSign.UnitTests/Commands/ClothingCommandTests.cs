using ClothingForDocuSign.Domain;
using ClothingForDocuSign.Domain.Commands;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ClothingForDocuSign.UnitTests.Commands
{
	[TestClass]
	public class ClothingCommandTests
	{
		[TestMethod]
		[ExpectedException(typeof(ArgumentNullException))]
		public void Constructor_Description_Should_Not_Be_NULL()
		{
			new ClothingCommand(1, null, "", "");
		}

		[TestMethod]
		[ExpectedException(typeof(ArgumentNullException))]
		public void Constructor2_Description_Should_Not_Be_NULL()
		{
			new ClothingCommand(1, null, "");
		}

		[TestMethod]
		[ExpectedException(typeof(ArgumentNullException))]
		public void Constructor2_Response_Should_Not_Be_NULL()
		{
			new ClothingCommand(1, "", null);
		}

		[TestMethod]
		public void Can_Response()
		{
			// Arrange
			var clothingCommand1 = new ClothingCommand(1, "Description", "HotResponse", "ColdResponse");
			var clothingCommand2 = new ClothingCommand(1, "Description", "Response");

			// Act
			var hotResponse1 = clothingCommand1.Response(TempratureType.HOT);
			var coldResponse1 = clothingCommand1.Response(TempratureType.COLD);

			var hotResponse2 = clothingCommand2.Response(TempratureType.HOT);
			var coldResponse2 = clothingCommand2.Response(TempratureType.COLD);

			// Assert
			Assert.AreEqual("HotResponse", hotResponse1);
			Assert.AreEqual("ColdResponse", coldResponse1);

			Assert.AreEqual("Response", hotResponse2);
			Assert.AreEqual("Response", coldResponse2);
		}

		[TestMethod]
		public void Can_Description()
		{
			// Arrange
			var clothingCommand1 = new ClothingCommand(1, "Description1", "", "");
			var clothingCommand2 = new ClothingCommand(1, "Description2", "");

			// Act
			var description1 = clothingCommand1.Description;
			var description2 = clothingCommand2.Description;

			// Assert
			Assert.AreEqual("Description1", description1);
			Assert.AreEqual("Description2", description2);
		}
	}
}
