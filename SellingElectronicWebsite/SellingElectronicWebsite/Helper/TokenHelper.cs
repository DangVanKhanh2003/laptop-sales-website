using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.IdentityModel.Tokens;
using SellingElectronicWebsite.Entities;
using SellingElectronicWebsite.Model;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Security.Cryptography;
using System.Text;

namespace SellingElectronicWebsite.Helper
{
    public class TokenHelper
    {

        private readonly SellingElectronicsContext _context;
        private readonly IConfiguration _configuration;

        // Use Dependency Injection to inject SellingElectronicsContext and IConfiguration
        public TokenHelper(SellingElectronicsContext context, IConfiguration configuration)
        {
            _context = context;
            _configuration = configuration;
        }
        public async Task<TokenModel> GenerateToken(int id,string email, string[] roles)
        {
            var jwtTokenHandler = new JwtSecurityTokenHandler();

            var secretKey = _configuration.GetValue<string>("JWT:SecretKey");
            var secretKeyBytes = Encoding.UTF8.GetBytes(secretKey);
            var claims = new List<Claim>
                {
                    new Claim(JwtRegisteredClaimNames.Jti, Guid.NewGuid().ToString()),
                    new Claim("Id", id.ToString()),
                    new Claim("Email", email.ToString()),

                };

            // Add each role as a separate claim
            foreach (var role in roles)
            {
                claims.Add(new Claim(ClaimTypes.Role, role.ToString()));
            }

            var tokenDescription = new SecurityTokenDescriptor
            {
                Subject = new ClaimsIdentity(claims),
                Expires = DateTime.UtcNow.AddDays(10),
                SigningCredentials = new SigningCredentials(new SymmetricSecurityKey(secretKeyBytes), SecurityAlgorithms.HmacSha512Signature)
            };

            var token = jwtTokenHandler.CreateToken(tokenDescription);
            var accessToken = jwtTokenHandler.WriteToken(token);
            var refreshToken = GenerateRefreshToken();

            //Lưu database
            var refreshTokenEntity = new RefreshTokenCustomer
            {
                JwtId = token.Id,
                CustomerId = id,
                Token = refreshToken,
                IsUsed = false,
                IsRevoked = false,
                IssuedAt = DateTime.UtcNow,
                ExpiredAt = DateTime.UtcNow.AddDays(30),
                Email = email
            };

            await _context.AddAsync(refreshTokenEntity);
            await _context.SaveChangesAsync();

            return new TokenModel
            {
                AccessToken = accessToken,
                RefreshToken = refreshToken
            };
        }

        public  string GenerateRefreshToken()
        {
            var random = new byte[32];
            using (var rng = RandomNumberGenerator.Create())
            {
                rng.GetBytes(random);

                return Convert.ToBase64String(random);
            }
        }
    }
}
