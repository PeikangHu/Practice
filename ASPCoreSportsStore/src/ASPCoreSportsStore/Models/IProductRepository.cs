﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ASPCoreSportsStore.Models
{
    public interface IProductRepository
    {
		IEnumerable<Product> Products { get; }
    }
}