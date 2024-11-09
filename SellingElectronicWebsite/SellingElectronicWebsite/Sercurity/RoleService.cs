using Microsoft.EntityFrameworkCore;
using SellingElectronicWebsite.Entities;

namespace SellingElectronicWebsite.Sercurity
{
    public class RoleService
    {
        private readonly SellingElectronicsContext _context;

        public RoleService(SellingElectronicsContext context)
        {
            _context = context;
        }

        // Check if a role exists
        public async Task<bool> RoleExistsAsync(string roleName)
        {
            var check = await _context.Roles.Where(r => r.RolesName == roleName).FirstOrDefaultAsync();
            if(check != null)
            {
                return true;
            }
            return false;
        }

        // Add a new role
        public async Task AddRoleAsync(string roleName)
        {
            if (!await RoleExistsAsync(roleName))
            {
                _context.Roles.Add(new Role { RolesName = roleName });
                await _context.SaveChangesAsync();
            }
        }

        // Retrieve a role by name
        public async Task<Role> GetRoleByNameAsync(string roleName)
        {
            return await _context.Roles.FirstOrDefaultAsync(r => r.RolesName == roleName);
        }
    }
}
