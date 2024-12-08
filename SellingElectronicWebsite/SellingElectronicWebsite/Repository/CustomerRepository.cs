using AutoMapper;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure;
using SellingElectronicWebsite.Entities;
using SellingElectronicWebsite.Helper;
using SellingElectronicWebsite.Model;
using SellingElectronicWebsite.ViewModel;
using System.Text.RegularExpressions;

namespace SellingElectronicWebsite.Repository
{
    public class CustomerRepository : ICustomersRepository
    {
        private SellingElectronicsContext _context;
        private readonly IMapper _mapper;


        public CustomerRepository(SellingElectronicsContext context, IMapper mapper)
        {
            _context = context;
            _mapper = mapper;

        }
        /// <summary>
        /// get all customer infor
        /// </summary>
        /// <param name="sortBy">defaul is null. you can fill:name_asc(sort ascending by name)/  name_desc(sort descending by name)</param>
        public async Task<List<CustomerVM>> GetAll(string sortBy)
        {
            var customers = await _context.Customers
                                 .Include(p => p.Address)  // Ensure the Address navigation property is included
                                 .Select(p => new CustomerVM(
                                     p.CustomerId,
                                     p.FullName,
                                     p.PhoneNumber,
                                     p.Address != null ?  // Check if Address is not null
                                         new AddressVM(
                                             p.Address.AddressId,
                                             p.Address.Province,
                                             p.Address.District,
                                             p.Address.Commune,
                                             p.Address.Street,
                                             p.Address.NumberHouse
                                         )
                                         : null  // If Address is null, set AddressVM to null
                                 ))
                                 .ToListAsync();



            if (!string.IsNullOrEmpty(sortBy))
            {
                switch (sortBy)
                {
                    case "name_asc": customers = customers.OrderBy(p => p.FullName).ToList(); break;
                    case "name_desc": customers = customers.OrderByDescending(p => p.FullName).ToList(); break;
                }
            }
            return customers;
        }
        /// <summary>
        /// get all customer infor by page
        /// </summary>
        /// <param name="sortBy">defaul is null. you can fill:name_asc(sort ascending by name)/  name_desc(sort descending by name)</param>
        public async Task<List<CustomerVM>> GetByPage(int pageIndex, int pageSize, string sortBy)
        {
            var customers = await _context.Customers
                     .Include(p => p.Address)
                    .Select(p => new CustomerVM(
                                     p.CustomerId,
                                     p.FullName,
                                     p.PhoneNumber,
                                     p.Address != null ?  // Check if Address is not null
                                         new AddressVM(
                                             p.Address.AddressId,
                                             p.Address.Province,
                                             p.Address.District,
                                             p.Address.Commune,
                                             p.Address.Street,
                                             p.Address.NumberHouse
                                         )
                                         : null
                                        )).ToListAsync();

            if (!string.IsNullOrEmpty(sortBy))
            {
                switch (sortBy)
                {
                    case "name_asc": customers = customers.OrderBy(p => p.FullName).ToList(); break;
                    case "name_desc": customers = customers.OrderByDescending(p => p.FullName).ToList(); break;
                }
            }
            var queryable = customers.AsQueryable();
            var customerPaging = PaginatedList<CustomerVM>.create(queryable, pageIndex, pageSize);

            return customerPaging;
        }
        public async Task<CustomerVM> GetById(int id)
        {
            var customer = await _context.Customers
                      .Include(p => p.Address)
                      .Where(p => p.CustomerId == id)
                     .Select(p => new CustomerVM(
                                     p.CustomerId,
                                     p.FullName,
                                     p.PhoneNumber,
                                     p.Address != null ?  // Check if Address is not null
                                         new AddressVM(
                                             p.Address.AddressId,
                                             p.Address.Province,
                                             p.Address.District,
                                             p.Address.Commune,
                                             p.Address.Street,
                                             p.Address.NumberHouse
                                         )
                                         : null
                                         )).FirstOrDefaultAsync();
            return customer;
        }

        public async Task<bool> Add(CustomerModel model)
        {
            var checkPhoneNumber = Regex.IsMatch(model.PhoneNumber, @"^\d{10}$");
            if(checkPhoneNumber == false)
            {
                throw new Exception("Phone number is invalid!");
            }
            Customer customer = _mapper.Map<Customer>(model);
            await _context.Customers.AddAsync(customer);
            return true;
        }

        public async Task<Customer> AddEmpty()
        {
            Customer customer = new Customer();
            await _context.Customers.AddAsync(customer);
            return customer;
        }

        public async Task<bool> Update(CustomerModel model, int id)
        {
            // check phone number
            var checkPhoneNumber = Regex.IsMatch(model.PhoneNumber, @"^\d{10}$");
            if (checkPhoneNumber == false)
            {
                throw new Exception("Phone number is invalid!");
            }

            //check customer
            var customer = await _context.Customers
                     .Where(p => p.CustomerId == id).FirstOrDefaultAsync();
            if(customer == null)
            {
                throw new Exception("Customer id: " + id + " isn't exist!");
            }

            var address = _context.Addresses.Where(p => p.AddressId == customer.AddressId).FirstOrDefault();
            // customer don't exist address
            if(address == null)
            {
                // add address
                Address newAddress = new Address();
                _mapper.Map(model.Address, newAddress);
                await _context.AddAsync(newAddress);
                await _context.SaveChangesAsync();
                // update customer
                _mapper.Map(model, customer);
                customer.AddressId = newAddress.AddressId;
                _context.Update(customer);

            }  
            else
            {
                _mapper.Map(model.Address, address);
                _mapper.Map(model, customer);
                _context.Update(address);
                _context.Update(customer);
            }
            
            return true;
        }

        public async Task<bool> DeleteByIdCustomer(int id)
        {
            var customer =await _context.Customers.Where(p => p.CustomerId == id).FirstOrDefaultAsync();  
            _context.Remove(customer);
            return true;
        }
    }
}
