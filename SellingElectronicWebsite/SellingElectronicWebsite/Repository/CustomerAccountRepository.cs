using BC = BCrypt.Net.BCrypt;
using SellingElectronicWebsite.Model;
using SellingElectronicWebsite.ViewModel;
using Microsoft.EntityFrameworkCore;
using AutoMapper;
using SellingElectronicWebsite.Entities;
using System.Runtime.CompilerServices;
using SellingElectronicWebsite.Helper;
using Microsoft.Extensions.Configuration;
using System.Text.Json;
namespace SellingElectronicWebsite.Repository
{

    public class CustomerAccountRepository : ICustomerAccountRepository
    {
        private SellingElectronicsContext _context;
        private readonly IMapper _mapper;
        private readonly IConfiguration _configuration;


        public CustomerAccountRepository(SellingElectronicsContext context, IMapper mapper, IConfiguration configuration)
        {
            _context = context;
            _mapper = mapper;
            _configuration = configuration;

        }
        /// <summary>
        /// if exist account return true else return false
        /// </summary>
        public async Task<string> CheckLogin(string email, string password)
        {
            AccountCustomer account = await _context.AccountCustomers.Where(x => x.Email == email).FirstOrDefaultAsync();
            // check account found and verify password
            if (account == null || !BC.Verify(password, account.Password))
            {
                throw new Exception("User name or password incorrect");
            }
            else
            {
                var user = await _context.Customers.Where(p => p.CustomerId == account.CustomerId).FirstOrDefaultAsync();
                if(user == null)
                {
                    throw new Exception("Customer don't exist");
                }
                //cấp token
                TokenHelper tokenHelper = new TokenHelper(_context, _configuration);
                var token = await tokenHelper.GenerateToken(user.CustomerId, email, ["customer"]);
                string jsonString = JsonSerializer.Serialize(token);
                return jsonString;
            }
            
        }
        /// <summary>
        /// not code yet
        /// </summary>
        
        public async Task<bool> DeleteAccountByIdCustomer(int id)
        {
            throw new NotImplementedException();
        }

        public async Task<List<CustomerAccountVM>> GetAll()
        {
            var listAccount = await _context.AccountCustomers.ToListAsync();
            return _mapper.Map<List<CustomerAccountVM>>(listAccount);
        }

        public async Task<CustomerAccountVM> GetByIdCustomer(int id)
        {
            AccountCustomer account = await _context.AccountCustomers.Where(x => x.CustomerId == id).FirstOrDefaultAsync();

            // check account found and verify password
            if (account == null)
            {
                throw new Exception("Account is not exist by id acount: " + id);
                // authentication failed
                return null;
            }
            else
            {
                // authentication successful
                return _mapper.Map<CustomerAccountVM>(account);
            }
        }

       
        public async Task<bool> checkEmailExist(string email)
        {
            var checkExistEmail = await _context.AccountCustomers.Where(x => x.Email == email).FirstOrDefaultAsync();
            if (checkExistEmail != null)
            {
                return true;
            }
            return false;
        }
        /// <summary>
        /// Need check email end user befor register.
        /// else return true.
        /// </summary>
      
        public async Task<bool> Register(CustomerAccountModel model)
        {
            var checkEmail = await checkEmailExist(model.Email);
            if(checkEmail)
            {
                throw new Exception("Email: '" + model.CustomerId + "' is already exist");
            }
            var checkExistCustomer = await _context.Customers.Where(x => x.CustomerId == model.CustomerId).FirstOrDefaultAsync();
            
            AccountCustomer account = _mapper.Map<AccountCustomer>(model);

            account.Password = BC.HashPassword(model.Password);

            await _context.AccountCustomers.AddAsync(account);
            return true;
        }

        /// <summary>
        /// if email and password is valid. The new password will be hash and update => return true.
        /// if email and password isn't invalid => return false
        /// </summary>
        public async Task<bool> ChangePassword(string email, string password, string newPassword)
        {
            var account = await _context.AccountCustomers.Where(x => x.Email == email).FirstOrDefaultAsync();
            var checkValidPassword = BC.Verify(password, account.Password);
            if (account != null && checkValidPassword)
            {
                account.Password = BC.HashPassword(newPassword);
                _context.Update(account);
                return true;
            }
            else
            {
                return false;
            }
        }

        public async Task<List<CustomerAccountVM>> GetByPage(int pageIndex, int pageSize)
        {
            var listAccount = await _context.AccountCustomers.ToListAsync();
            var customerAccounts =  _mapper.Map<List<CustomerAccountVM>>(listAccount);
            var queryable = customerAccounts.AsQueryable();
            var items = PaginatedList<CustomerAccountVM>.create(queryable, pageIndex, pageSize);
            return items;
        }
    }
}
