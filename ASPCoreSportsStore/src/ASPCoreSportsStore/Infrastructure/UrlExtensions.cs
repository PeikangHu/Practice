using Microsoft.AspNetCore.Http;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ASPCoreSportsStore.Infrastructure
{
    public static class UrlExtensions
    {
		// generates a URL that the browser will be returned to
		// after the cart has been updated
		public static string PathAndQuery(this HttpRequest request) =>
			request.QueryString.HasValue ? $"{request.Path}{request.QueryString}"
			: request.Path.ToString();
    }
}
