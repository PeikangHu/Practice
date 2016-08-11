using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using System.Collections.Generic;
using ClothingForDocuSign.Domain.Infrastructure.ExecutionPlans;
using Newtonsoft.Json;
using System.Linq;
using System.Reflection;

namespace ClothingForDocuSign.UnitTests.Infrastructure.ExecutionPlans
{
	[TestClass]
	public class ExecutionPlanTests
	{
		[TestMethod]
		// Assert
		[ExpectedException(typeof(ArgumentNullException))]
		public void Constructor_AdjacencyMatrix_Should_Not_Be_Null()
		{
			// Arrange - taskAndIndegree
			var taskAndIndegree = new Dictionary<int, int>();

			var executionPlan = new ExecutionPlan<int>(null, taskAndIndegree);
		}

		[TestMethod]
		// Assert
		[ExpectedException(typeof(ArgumentNullException))]
		public void Constructor_TaskAndIndegree_Shoud_Not_Be_Null()
		{
			// Arrange - adjacencyMatrix
			var adjacencyMatrix = new Dictionary<int, IList<int>>();

			var executionPlan = new ExecutionPlan<int>(adjacencyMatrix, null);
		}

		[TestMethod]
		public void Can_Get_AdjacencyMatrix()
		{
			// Arrange - adjacencyMatrix
			var adjacencyMatrix = new Dictionary<int, IList<int>>();
			adjacencyMatrix.Add(1, new List<int>() { 2, 3 });
			adjacencyMatrix.Add(2, new List<int>());

			// Arrange - taskAndIndegree
			var taskAndIndegree = new Dictionary<int, int>();

			// Arrange - executionPlan
			var executionPlan = new ExecutionPlan<int>(adjacencyMatrix, taskAndIndegree);

			// Act
			var adjacencyMatrixActual = executionPlan.AdjacencyMatrix;

			// Assert
			var adjacencyMatrixActualStr = string.Join(",", adjacencyMatrixActual.Select(kv => kv.Key + "=" + string.Join(",", kv.Value.ToArray())).ToArray());
			var adjacencyMatrixStr = string.Join(",", adjacencyMatrix.Select(kv => kv.Key + "=" + string.Join(",", kv.Value.ToArray())).ToArray());

			Assert.AreEqual(adjacencyMatrixStr, adjacencyMatrixActualStr);
		}

		[TestMethod]
		public void Can_Get_TaskAndIndegree()
		{
			// Arrange - adjacencyMatrix
			var adjacencyMatrix = new Dictionary<int, IList<int>>();

			// Arrange - taskAndIndegree
			var taskAndIndegree = new Dictionary<int, int>();
			taskAndIndegree.Add(1, 1);
			taskAndIndegree.Add(2, 2);

			// Arrange - executionPlan
			var executionPlan = new ExecutionPlan<int>(adjacencyMatrix, taskAndIndegree);

			// Act
			var taskAndIndegreeActual = executionPlan.TaskAndIndegree;

			// Assert
			var taskAndIndegreeActualStr = string.Join(",", string.Join(",", taskAndIndegreeActual.Select(kv => kv.Key + "=" + kv.Value).ToArray()));
			var taskAndIndegreeStr = string.Join(",", string.Join(",", taskAndIndegree.Select(kv => kv.Key + "=" + kv.Value).ToArray()));

			Assert.AreEqual(taskAndIndegreeStr, taskAndIndegreeActualStr);
		}

		[TestMethod]
		public void Can_ToString()
		{
			// Arrange - adjacencyMatrix
			var adjacencyMatrix = new Dictionary<int, IList<int>>();
			adjacencyMatrix.Add(1, new List<int>() { 2, 3 });
			adjacencyMatrix.Add(2, new List<int>());

			// Arrange - taskAndIndegree
			var taskAndIndegree = new Dictionary<int, int>();
			taskAndIndegree.Add(1, 1);
			taskAndIndegree.Add(2, 2);

			// Arrange - executionPlan
			var executionPlan = new ExecutionPlan<int>(adjacencyMatrix, taskAndIndegree);

			// Act
			var executionPlanStr = executionPlan.ToString();

			// Assert
			Assert.AreEqual("AdjacencyMatrix: 1=2,3,2= | TaskAndIndegree: 1=1,2=2", executionPlanStr);
		}

		[TestMethod]
		public void Can_Restart()
		{
			// Arrange - adjacencyMatrix
			var adjacencyMatrix = new Dictionary<int, IList<int>>();

			// Arrange - taskAndIndegree
			var taskAndIndegree = new Dictionary<int, int>();
			taskAndIndegree.Add(1, 1);

			// Arrange - executionPlan
			var executionPlan = new ExecutionPlan<int>(adjacencyMatrix, taskAndIndegree);

			// Arrange - change the value of _taskAndIndegree
			var modifiedTaskAndIndegree = new Dictionary<int, int>();
			modifiedTaskAndIndegree.Add(3, 3);

			FieldInfo taskAndIndegreeField = executionPlan.GetType().GetField("_taskAndIndegree",
										BindingFlags.NonPublic | BindingFlags.Instance);
			taskAndIndegreeField.SetValue(executionPlan, modifiedTaskAndIndegree);

			var modifiedValue = (Dictionary<int, int>)taskAndIndegreeField.GetValue(executionPlan);
			var modifiedValueStr = string.Join(",", string.Join(",", modifiedValue.Select(kv => kv.Key + "=" + kv.Value).ToArray()));

			// Act
			executionPlan.Restart();
			var initialValue = (Dictionary<int, int>)taskAndIndegreeField.GetValue(executionPlan);
			var initialValueStr = string.Join(",", string.Join(",", initialValue.Select(kv => kv.Key + "=" + kv.Value).ToArray()));

			// Assert
			Assert.AreNotEqual(modifiedValueStr, initialValueStr);
		}

		private ExecutionPlan<int> ExecutionPlanForTestingRun()
		{
			// Arrange - adjacencyMatrix
			var adjacencyMatrix = new Dictionary<int, IList<int>>();
			adjacencyMatrix.Add(1, new List<int>() { 2, 3 });
			adjacencyMatrix.Add(2, new List<int>());
			adjacencyMatrix.Add(3, new List<int>() { 4 });
			adjacencyMatrix.Add(4, new List<int>());

			// Arrange - taskAndIndegree
			var taskAndIndegree = new Dictionary<int, int>();
			taskAndIndegree.Add(1, 0);
			taskAndIndegree.Add(2, 1);
			taskAndIndegree.Add(3, 1);
			taskAndIndegree.Add(4, 1);

			// Arrange - executionPlan
			var executionPlan = new ExecutionPlan<int>(adjacencyMatrix, taskAndIndegree);
			return executionPlan;
		}

		[TestMethod]
		public void Can_Run_All_Right()
		{
			// Arrange - executionPlan
			var executionPlan = ExecutionPlanForTestingRun();

			// Act
			var step1Result = executionPlan.Run(1);
			var step2Result = executionPlan.Run(2);
			var step3Result = executionPlan.Run(3);

			// Assert
			Assert.AreEqual(true, step1Result);
			Assert.AreEqual(true, step2Result);
			Assert.AreEqual(true, step3Result);
		}

		[TestMethod]
		public void Can_Run_Wrong_Sequence()
		{
			// Arrange - executionPlan
			var executionPlan = ExecutionPlanForTestingRun();

			// Act
			var step1Result = executionPlan.Run(2);
			var step2Result = executionPlan.Run(1);
			var step3Result = executionPlan.Run(4);
			var step4Result = executionPlan.Run(1);
			var step5Result = executionPlan.Run(1);

			// Assert
			Assert.AreEqual(false, step1Result);
			Assert.AreEqual(true, step2Result);
			// 4 is under 3, so 3 should run first.
			Assert.AreEqual(false, step3Result);
			// because once it fails, it will recover taskAndIndegree.
			Assert.AreEqual(true, step4Result);
			// because 1 has been executed, the degree should be -1.
			Assert.AreEqual(false, step5Result);
		}


	}
}
