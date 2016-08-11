using ClothingForDocuSign.Domain.Commands;
using ClothingForDocuSign.Domain.Infrastructure.ExecutionPlans;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ClothingForDocuSign.Domain.Rules
{
	public interface IClothingRules
	{
		IExecutionPlan<IClothingCommand> Rules { get; }
	}
}
