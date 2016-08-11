using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ClothingForDocuSign.Domain.Infrastructure.IdentityObject
{
	public abstract class IdentityUsingIntObject : IIdentityObject<int>
	{
		private readonly int _id;

		public IdentityUsingIntObject(int id)
		{
			_id = id;
		}

		public int ID
		{
			get
			{
				return _id;
			}
		}

		public override bool Equals(object obj)
		{
			if (obj == null)
			{
				return false;
			}
			var p = obj as IdentityUsingIntObject;
			// Return true if the fields match:
			return ID == p.ID;
		}

		public bool Equals(IdentityUsingIntObject identityUsingIntObject)
		{
			if (identityUsingIntObject == null)
			{
				return false;
			}
			return ID == identityUsingIntObject.ID;
		}

		public override int GetHashCode()
		{
			return _id;
		}

		public static bool operator ==(IdentityUsingIntObject a, IdentityUsingIntObject b)
		{
			// If both are null, or both are same instance, return true.
			if (ReferenceEquals(a, b))
			{
				return true;
			}

			// If one is null, but not both, return false.
			if (((object)a == null) || ((object)b == null))
			{
				return false;
			}

			// Return true if the fields match:
			return a.ID == b.ID;
		}

		public static bool operator !=(IdentityUsingIntObject a, IdentityUsingIntObject b)
		{
			return !(a == b);
		}
	}
}
