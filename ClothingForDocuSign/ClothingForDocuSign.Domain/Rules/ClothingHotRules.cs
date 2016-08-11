using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using ClothingForDocuSign.Domain.Commands;
using ClothingForDocuSign.Domain.Infrastructure.ExecutionPlans;

namespace ClothingForDocuSign.Domain.Rules
{
	public class ClothingHotRules : IClothingRules
	{
		private readonly IClothingCommandRepository _clothingCommandRepository;
		private IExecutionPlan<IClothingCommand> _rules;
		public ClothingHotRules(IClothingCommandRepository clothingCommandRepository)
		{
			_clothingCommandRepository = clothingCommandRepository;

			_rules = GenerateRules();
		}

		private IExecutionPlan<IClothingCommand> GenerateRules()
		{
			var executionPlanBuilder = new ExecutionPlanBuilder<IClothingCommand>();

			executionPlanBuilder.Add(_clothingCommandRepository.Get(8), _clothingCommandRepository.Get(6));
			executionPlanBuilder.Add(_clothingCommandRepository.Get(8), _clothingCommandRepository.Get(4));
			executionPlanBuilder.Add(_clothingCommandRepository.Get(6), _clothingCommandRepository.Get(1));
			executionPlanBuilder.Add(_clothingCommandRepository.Get(4), _clothingCommandRepository.Get(2));
			executionPlanBuilder.Add(_clothingCommandRepository.Get(1), _clothingCommandRepository.Get(7));
			executionPlanBuilder.Add(_clothingCommandRepository.Get(2), _clothingCommandRepository.Get(7));

			return executionPlanBuilder.Build();
		}

		public IExecutionPlan<IClothingCommand> Rules
		{
			get
			{
				return _rules;
			}
		}
	}
}
