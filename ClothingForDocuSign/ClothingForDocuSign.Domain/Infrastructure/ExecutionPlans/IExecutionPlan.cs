using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ClothingForDocuSign.Domain.Infrastructure.ExecutionPlans
{
	public interface IExecutionPlan<T>
	{
		IReadOnlyDictionary<T, IList<T>> AdjacencyMatrix { get; }
		IReadOnlyDictionary<T, int> TaskAndIndegree { get; }

		bool Run(T task);
		void Restart();
	}
}
