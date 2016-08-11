using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using ClothingForDocuSign.Domain.Commands;
using ClothingForDocuSign.Domain.Rules;

namespace ClothingForDocuSign.UnitTests.Rules
{
	[TestClass]
	public class ClothingHotRulesTests
	{
		[TestMethod]
		public void Can_Get_Rules()
		{
			// Arrange
			var clothingCommandRepository = new MemoryClothingCommandRepository();

			var clothingHotRules = new ClothingHotRules(clothingCommandRepository);

			// Act
			var rules = clothingHotRules.Rules;

			// Assert
			Assert.AreEqual(6, rules.TaskAndIndegree.Count);
		}
	}
}
