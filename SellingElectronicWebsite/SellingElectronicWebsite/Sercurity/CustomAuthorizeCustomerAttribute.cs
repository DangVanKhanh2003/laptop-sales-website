using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Filters;
using System.Security.Claims;

namespace SellingElectronicWebsite.Sercurity
{
    public class CustomAuthorizeCustomerAttribute : TypeFilterAttribute
    {
        public CustomAuthorizeCustomerAttribute(string role) : base(typeof(CustomAuthorizeCustomerFilter))
        {
            Arguments = new object[] { role };
        }
    }
   
}

