using System;
using System.Collections.Generic;

namespace ClothingForDocuSign.Domain.Infrastructure.ExecutionPlans
{
	public class ExecutionPlanBuilder<T>
	{
		private HashSet<T> _tasks;
		private List<Path<T>> _paths;

		public ExecutionPlanBuilder()
		{
			_tasks = new HashSet<T>();
			_paths = new List<Path<T>>();
		}

		public void Add(T from, T to)
		{
			if (from == null || to == null) throw new ArgumentNullException("'from' and 'to' could not be null.");

			if (!_tasks.Contains(from)) _tasks.Add(from);
			if (!_tasks.Contains(to)) _tasks.Add(to);

			var path = new Path<T>(from, to);
			_paths.Add(path);
		}

		public ExecutionPlan<T> Build()
		{
			IDictionary<T, IList<T>>	adjacencyMatrix = new Dictionary<T, IList<T>>();
			IDictionary<T, int>			taskAndIndegree = new Dictionary<T, int>();

			foreach (var task in _tasks)
			{
				adjacencyMatrix.Add(task, new List<T>());
				taskAndIndegree.Add(task, 0);
			}

			foreach (var path in _paths)
			{
				adjacencyMatrix[path.From].Add(path.To);
				taskAndIndegree[path.To] += 1;
			}

			var executionPlan = new ExecutionPlan<T>(adjacencyMatrix, taskAndIndegree);

			return executionPlan;
		}
	}
}
