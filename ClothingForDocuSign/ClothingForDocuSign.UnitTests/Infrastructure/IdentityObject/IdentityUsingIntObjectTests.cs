using ClothingForDocuSign.Domain.Infrastructure.IdentityObject;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Moq;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;

namespace ClothingForDocuSign.UnitTests.Infrastructure.IdentityObject
{
	[TestClass]
	public class IdentityUsingIntObjectTests
	{
		public class MyAbstractIdentityUsingIntObject : IdentityUsingIntObject
		{
			public MyAbstractIdentityUsingIntObject(int id) : base(id)
			{
			}
		}

		[TestMethod]
		public void Are_Equal()
		{
			var identityUsingIntObject1 = new MyAbstractIdentityUsingIntObject(1);
			var identityUsingIntObject2 = new MyAbstractIdentityUsingIntObject(1);

			Assert.IsTrue(identityUsingIntObject1 == identityUsingIntObject2);
			Assert.IsTrue(null == null);
			Assert.IsFalse(null == identityUsingIntObject2);
			Assert.IsFalse(identityUsingIntObject1 == null);
			Assert.IsFalse(identityUsingIntObject1 != identityUsingIntObject2);
			Assert.IsTrue(identityUsingIntObject1.Equals(identityUsingIntObject2));
			Assert.IsTrue(identityUsingIntObject1.Equals((object)identityUsingIntObject2));
			Assert.IsFalse(identityUsingIntObject1.Equals((object)null));
			Assert.IsFalse(identityUsingIntObject1.Equals(null));
		}

		[TestMethod]
		public void Can_Get_ID()
		{
			var identityUsingIntObject1 = new MyAbstractIdentityUsingIntObject(1);
			Assert.AreEqual(1, identityUsingIntObject1.ID);
		}

		[TestMethod]
		public void Can_Not_Add_Same_Object_Into_HashSet()
		{
			var identityUsingIntObject1 = new MyAbstractIdentityUsingIntObject(1);
			var identityUsingIntObject2 = new MyAbstractIdentityUsingIntObject(1);

			var hashSet = new HashSet<MyAbstractIdentityUsingIntObject>();
			hashSet.Add(identityUsingIntObject1);
			hashSet.Add(identityUsingIntObject2);

			Assert.AreEqual(1, hashSet.Count());
		}

		[TestMethod]
		public void Can_Generate_Hash_Code()
		{
			var identityUsingIntObject1 = new MyAbstractIdentityUsingIntObject(1);

			Assert.AreEqual(1, identityUsingIntObject1.GetHashCode());
		}
	}
}

