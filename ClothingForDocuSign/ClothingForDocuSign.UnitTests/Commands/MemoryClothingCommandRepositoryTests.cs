using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using ClothingForDocuSign.Domain.Commands;

namespace ClothingForDocuSign.UnitTests.Commands
{
	[TestClass]
	public class MemoryClothingCommandRepositoryTests
	{
		[TestMethod]
		public void Can_ClothingCommands()
		{
			var memoryClothingCommandRepository = new MemoryClothingCommandRepository();
			Assert.AreEqual(8, memoryClothingCommandRepository.ClothingCommands.Count);
		}

		[TestMethod]
		[ExpectedException(typeof(ArgumentOutOfRangeException))]
		public void Get_Id_Can_Not_Invalid()
		{
			var memoryClothingCommandRepository = new MemoryClothingCommandRepository();
			memoryClothingCommandRepository.Get(int.MaxValue);
		}

		[TestMethod]
		public void Can_Get()
		{
			var memoryClothingCommandRepository = new MemoryClothingCommandRepository();
			Assert.AreEqual(1, memoryClothingCommandRepository.Get(1).ID);
			Assert.AreEqual(5, memoryClothingCommandRepository.Get(5).ID);
		}
	}
}
