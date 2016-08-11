using ClothingForDocuSign.Domain;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ClothingForDocuSign
{
	public interface IClothingController
	{
		void OnInputFinished(TempratureType? tempratureType, IList<int> commandIds, bool exit = false);

		void Start();
	}
}
