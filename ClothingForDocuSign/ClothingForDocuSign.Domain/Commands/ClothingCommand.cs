using ClothingForDocuSign.Domain.Infrastructure.IdentityObject;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ClothingForDocuSign.Domain.Commands
{
	public class ClothingCommand : IdentityUsingIntObject, IClothingCommand
	{
		private readonly string _description;
		private readonly string _hotResponse;
		private readonly string _coldResponse;

		public ClothingCommand(int id, string description, string hotResponse, string coldResponse):base(id)
		{
			if (description == null)
				throw new ArgumentNullException("Description could not be NULL.");

			_description = description;
			_hotResponse = hotResponse;
			_coldResponse = coldResponse;
		}

		public ClothingCommand(int id, string description, string response) : base(id)
		{
			if (description == null || response == null)
				throw new ArgumentNullException("Description and response could not be NULL.");

			_description = description;
			_hotResponse = response;
			_coldResponse = response;
		}

		public string Response(TempratureType tempratureType)
		{
			switch (tempratureType)
			{
				case TempratureType.HOT: return _hotResponse;
				default:
					//TempratureType.COLD:
					return _coldResponse;
			}
		}

		public string Description
		{
			get
			{
				return _description;
			}
		}
	}
}
