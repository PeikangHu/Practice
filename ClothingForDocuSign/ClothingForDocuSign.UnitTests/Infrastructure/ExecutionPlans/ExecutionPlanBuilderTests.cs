using Microsoft.VisualStudio.TestTools.UnitTesting;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using ClothingForDocuSign.Domain.Commands;
using Moq;
using System.Reflection;
using ClothingForDocuSign.Domain.Infrastructure.ExecutionPlans;
using System.Collections.ObjectModel;

namespace ClothingForDocuSign.Domain.UnitTests.Infrastructure.ExecutionPlans
{
	[TestClass]
	public class ExecutionPlanBuilderTests
	{
		[TestMethod]
		// Assert
		[ExpectedException(typeof(ArgumentNullException))]
		public void Add_From_Should_Not_Be_NULL()
		{
			// Arrange 
			var clothingCommandMockTo = new Mock<IClothingCommand>();
			clothingCommandMockTo.Setup(m => m.ID).Returns(2);

			// Act
			var executionPlanBuilder = new ExecutionPlanBuilder<IClothingCommand>();
			executionPlanBuilder.Add(null, clothingCommandMockTo.Object);
		}

		[TestMethod]
		// Assert
		[ExpectedException(typeof(ArgumentNullException))]
		public void Add_To_Should_Not_Be_NULL()
		{
			// Arrange 
			var clothingCommandMockFrom = new Mock<IClothingCommand>();
			clothingCommandMockFrom.Setup(m => m.ID).Returns(1);

			// Act
			var executionPlanBuilder = new ExecutionPlanBuilder<IClothingCommand>();
			executionPlanBuilder.Add(clothingCommandMockFrom.Object, null);
		}

		[TestMethod]
		public void Can_Add()
		{
			// Arrange 
			var clothingCommandMockFrom = new Mock<IClothingCommand>();
			clothingCommandMockFrom.Setup(m => m.ID).Returns(1);

			var clothingCommandMockTo = new Mock<IClothingCommand>();
			clothingCommandMockTo.Setup(m => m.ID).Returns(2);

			var executionPlanBuilder = new ExecutionPlanBuilder<IClothingCommand>();

			// Act
			executionPlanBuilder.Add(clothingCommandMockFrom.Object, clothingCommandMockTo.Object);

			FieldInfo commandsField = executionPlanBuilder.GetType().GetField("_tasks",
										BindingFlags.NonPublic | BindingFlags.Instance);

			FieldInfo pathsField = executionPlanBuilder.GetType().GetField("_paths",
										BindingFlags.NonPublic | BindingFlags.Instance);

			// Assert
			Assert.AreEqual(2, ((HashSet<IClothingCommand>)commandsField.GetValue(executionPlanBuilder)).Count);
			Assert.AreEqual(1, ((List<Path<IClothingCommand>>)pathsField.GetValue(executionPlanBuilder)).Count);
		}

		[TestMethod]
		public void Can_Build()
		{
			/*
				AdjacencyMatrix and taskAndIndegree are useless for this test.
				I just want to show how an execution plan should be because the result for ToString() is messy.
			 */

			// Arrange - adjacencyMatrix
			var adjacencyMatrix = new Dictionary<int, IList<int>>();
			adjacencyMatrix.Add(1, new List<int>() { 2, 3 });
			adjacencyMatrix.Add(2, new List<int>());
			adjacencyMatrix.Add(3, new List<int>());

			// Arrange - taskAndIndegree
			var taskAndIndegree = new Dictionary<int, int>();
			taskAndIndegree.Add(1, 0);
			taskAndIndegree.Add(2, 1);
			taskAndIndegree.Add(3, 1);

			// Arrange - executionPlanExpected
			var executionPlanExpectedMock = new Mock<IExecutionPlan<int>>();
			executionPlanExpectedMock.Setup(m => m.AdjacencyMatrix).Returns(adjacencyMatrix);
			executionPlanExpectedMock.Setup(m => m.TaskAndIndegree).Returns(taskAndIndegree);
			executionPlanExpectedMock.Setup(m => m.ToString()).Returns("AdjacencyMatrix: 1=2,3,2=,3= | TaskAndIndegree: 1=0,2=1,3=1");

			var executionPlanExpected = executionPlanExpectedMock.Object;

			// Arrange - executionPlanBuilder
			var executionPlanBuilder = new ExecutionPlanBuilder<int>();
			executionPlanBuilder.Add(1, 2);
			executionPlanBuilder.Add(1, 3);

			// Act
			var executionPlanActual = executionPlanBuilder.Build();
			// Assert
			Assert.AreEqual(executionPlanExpected.ToString(), executionPlanActual.ToString());
		}
	}
}
