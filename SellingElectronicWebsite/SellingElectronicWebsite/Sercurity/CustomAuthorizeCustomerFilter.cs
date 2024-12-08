using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Filters;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using SellingElectronicWebsite.Entities;
using SellingElectronicWebsite.Helper;
using SellingElectronicWebsite.Model;
using System.Data;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;
using System.Text.Json;

namespace SellingElectronicWebsite.Sercurity
{
    public class CustomAuthorizeCustomerFilter : AuthorizeAttribute, IAsyncAuthorizationFilter
    {
        private readonly string[] _roles;
        private readonly SellingElectronicsContext _context;
        private readonly IConfiguration _configuration;


        public CustomAuthorizeCustomerFilter(string roles,  IConfiguration configuration)
        {
            _roles = roles.Split(',');
            _configuration = configuration;
        }

        public async Task OnAuthorizationAsync(AuthorizationFilterContext authorContext)
        {
            //get db context
            var _context = authorContext.HttpContext.RequestServices.GetRequiredService<SellingElectronicsContext>();
            var authorizationHeader = authorContext.HttpContext.Request.Headers["Authorization"];

            // Deserialize the JSON in the `Authorization` header to extract the tokens.
            if (!string.IsNullOrEmpty(authorizationHeader))
            {
                try
                {
                    var tokenData = JsonSerializer.Deserialize<TokenModel>(authorizationHeader);
                    var accessToken = tokenData?.AccessToken;
                    var refreshToken = tokenData?.RefreshToken;

                    var jwtTokenHandler = new JwtSecurityTokenHandler();
                    var secretKey = _configuration.GetValue<string>("JWT:SecretKey");
                    var secretKeyBytes = Encoding.UTF8.GetBytes(secretKey);
                    var tokenValidateParam = new TokenValidationParameters
                    {
                        //tự cấp token
                        ValidateIssuer = false,
                        ValidateAudience = false,

                        //ký vào token
                        ValidateIssuerSigningKey = true,
                        IssuerSigningKey = new SymmetricSecurityKey(secretKeyBytes),

                        ClockSkew = TimeSpan.Zero,

                        ValidateLifetime = false //ko kiểm tra token hết hạn
                    };

                    //check 1: AccessToken valid format
                    var tokenInVerification = jwtTokenHandler.ValidateToken(accessToken, tokenValidateParam, out var validatedToken);

                    //check 2: Check alg
                    if (validatedToken is JwtSecurityToken jwtSecurityToken)
                    {
                        var result = jwtSecurityToken.Header.Alg.Equals(SecurityAlgorithms.HmacSha512, StringComparison.InvariantCultureIgnoreCase);
                        if (!result)//false
                        {
                            authorContext.Result = new ContentResult
                            {
                                StatusCode = 401, // Unauthorized status code
                                Content = "Invalid token", // Add your message here
                                ContentType = "text/plain" // Set the content type
                            };
                            return;

                        }
                    }
                    //check 3: Role validation
                    var userRoles = tokenInVerification.Claims.Where(c => c.Type == ClaimTypes.Role).Select(c => c.Value).ToList();
                    if (!_roles.Any(role => userRoles.Contains(role, StringComparer.OrdinalIgnoreCase)))
                    {
                        authorContext.Result = new ContentResult { StatusCode = 403, Content = "Access denied. Insufficient role permissions.", ContentType = "text/plain" };
                        return;
                    }
                    //check 4: Check accessToken expire?
                    long utcExpireDate = long.Parse(tokenInVerification.Claims.FirstOrDefault(x => x.Type == JwtRegisteredClaimNames.Exp).Value);

                    var date = new DateTime(1970, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc);
                    var expireDate = date.AddSeconds(utcExpireDate);
                    // if expired
                    if (expireDate < DateTime.UtcNow)
                    {
                        //check 5: Check refreshtoken exist in DB
                        var storedToken = _context.RefreshTokenCustomers.FirstOrDefault(x => x.Token == refreshToken);
                        if (storedToken == null)
                        {
                            authorContext.Result = new ContentResult
                            {
                                StatusCode = 401, // Unauthorized status code
                                Content = "Refresh token does not exist", // Add your message here
                                ContentType = "text/plain" // Set the content type
                            };
                            return;
                        }

                        //check 6: check refreshToken is used/revoked?
                        if ((bool)storedToken.IsUsed)
                        {
                            authorContext.Result = new ContentResult { StatusCode = 401, Content = "Refresh token has been used", ContentType = "text/plain" };
                            return;

                        }
                        if ((bool)storedToken.IsRevoked)
                        {
                            authorContext.Result = new ContentResult { StatusCode = 401, Content = "Refresh token has been revoked", ContentType = "text/plain" };
                            return;

                        }

                        //check 7: AccessToken id == JwtId in RefreshToken
                        var jti = tokenInVerification.Claims.FirstOrDefault(x => x.Type == JwtRegisteredClaimNames.Jti).Value;
                        if (storedToken.JwtId != jti)
                        {
                            authorContext.Result = new ContentResult { StatusCode = 401, Content = "Token doesn't match", ContentType = "text/plain" };
                            return;

                        }

                        //Update token is used
                        storedToken.IsRevoked = true;
                        storedToken.IsUsed = true;
                        _context.Update(storedToken);
                        await _context.SaveChangesAsync();
                        //renew token
                        TokenHelper tokenHelper = new TokenHelper(_context, _configuration);
                        var user = await _context.Customers.Where(p => p.CustomerId == storedToken.CustomerId).FirstOrDefaultAsync();
                        var renewToken = await tokenHelper.GenerateToken(user.CustomerId, storedToken.Email ,_roles);
                        //convert to json
                        string jsonRenewToken = JsonSerializer.Serialize(renewToken);
                        authorContext.HttpContext.Response.Headers.Add("Authorization", jsonRenewToken);
                        return;

                    }


                }
                catch (JsonException ex)
                {
                    // Handle invalid JSON format
                    Console.WriteLine("Invalid JSON format in Authorization header: " + ex.Message);
                    authorContext.Result = new UnauthorizedResult();
                    return;
                }
            }
            else
            {
                authorContext.Result = new ContentResult { StatusCode = 401, Content = "Token cannot be empty", ContentType = "text/plain" };
               
            }
        }

       
    }
}
