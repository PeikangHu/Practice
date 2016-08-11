using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ClothingForDocuSign.Domain.Infrastructure.ExecutionPlans
{
	public class Path<T>
	{
		private T _from;
		private T _to;

		public Path(T from, T to)
		{
			if (from == null || to == null) throw new ArgumentNullException("'from' and 'to' should not be null.");

			_from = from;
			_to = to;
		}
		public T From { get { return _from; } }
		public T To { get { return _to; } }
	}
}
