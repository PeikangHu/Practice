using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using ClothingForDocuSign.Domain.Infrastructure.ExecutionPlans;

namespace ClothingForDocuSign.UnitTests.Infrastructure.ExecutionPlans
{
	[TestClass]
	public class PathTests
	{
		[TestMethod]
		[ExpectedException(typeof(ArgumentNullException))]
		public void Constructor_From_Should_Not_Be_NULL()
		{
			var to = new object();
			var path = new Path<object>(null, to);
		}

		[TestMethod]
		[ExpectedException(typeof(ArgumentNullException))]
		public void Constructor_To_Should_Not_Be_NULL()
		{
			var from = new object();
			var path = new Path<object>(from, null);
		}

		[TestMethod]
		public void Can_Get_From()
		{
			var from = 1;
			var to = 2;

			var path = new Path<int>(from, to);

			Assert.AreEqual(path.From, 1);
		}

		[TestMethod]
		public void Can_Get_To()
		{
			var from = 1;
			var to = 2;

			var path = new Path<int>(from, to);

			Assert.AreEqual(path.To, 2);
		}
	}
}
