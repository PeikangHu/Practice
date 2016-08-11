using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ClothingForDocuSign.Domain.Infrastructure.ExecutionPlans
{
	public class ExecutionPlan<T> : IExecutionPlan<T>
	{
		public IReadOnlyDictionary<T, IList<T>> AdjacencyMatrix { get { return _readOnlyAdjacencyMatrix; } }
		public IReadOnlyDictionary<T, int> TaskAndIndegree { get { return _readOnlyTaskAndIndegree; } }

		private IReadOnlyDictionary<T, IList<T>> _readOnlyAdjacencyMatrix;
		private IReadOnlyDictionary<T, int> _readOnlyTaskAndIndegree;


		private IDictionary<T, int> _taskAndIndegree;

		public ExecutionPlan(IDictionary<T, IList<T>> adjacencyMatrix,
							 IDictionary<T, int> taskAndIndegree)
		{
			if (adjacencyMatrix == null || taskAndIndegree == null)
				new ArgumentNullException("AdjacencyMatrix and taskAndIndegree should not be NULL.");

			_readOnlyAdjacencyMatrix = new ReadOnlyDictionary<T, IList<T>>(adjacencyMatrix);
			_readOnlyTaskAndIndegree = new ReadOnlyDictionary<T, int>(taskAndIndegree);

			_taskAndIndegree = _readOnlyTaskAndIndegree.ToDictionary(p => p.Key, p => p.Value);
		}

		public void Restart()
		{
			_taskAndIndegree = _readOnlyTaskAndIndegree.ToDictionary(p => p.Key, p => p.Value);
		}
		public bool Run(T task)
		{
			bool canContinue = true;
			if (_taskAndIndegree[task] == 0)
			{
				_taskAndIndegree[task]--;
				var followingTasks = _readOnlyAdjacencyMatrix[task];
				foreach (var followingTask in followingTasks)
				{
					_taskAndIndegree[followingTask]--;
				}

				canContinue = true;
			}
			else
			{
				Restart();
				canContinue = false;
			}

			return canContinue;
		}

		public override string ToString()
		{
			var adjacencyMatrixString = string.Join(",", _readOnlyAdjacencyMatrix.Select(kv => kv.Key + "=" + string.Join(",", kv.Value.ToArray())).ToArray());
			var taskAndIndegreeJson = string.Join(",", _readOnlyTaskAndIndegree.Select(kv => kv.Key + "=" + kv.Value).ToArray());

			return $"AdjacencyMatrix: {adjacencyMatrixString} | TaskAndIndegree: {taskAndIndegreeJson}";
		}
	}
}
