using ClothingForDocuSign.Domain.Commands;
using ClothingForDocuSign.Domain.Rules;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ClothingForDocuSign.UnitTests.Rules
{
	[TestClass]
	public class ClothingColdRulesTests
	{
		[TestMethod]
		public void Can_Get_Rules()
		{
			// Arrange
			var clothingCommandRepository = new MemoryClothingCommandRepository();

			var clothingHotRules = new ClothingColdRules(clothingCommandRepository);

			// Act
			var rules = clothingHotRules.Rules;

			// Assert
			Assert.AreEqual(8, rules.TaskAndIndegree.Count);
		}
	}
}
