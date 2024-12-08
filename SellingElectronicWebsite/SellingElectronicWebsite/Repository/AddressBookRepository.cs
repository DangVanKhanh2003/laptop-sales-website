using AutoMapper;
using Microsoft.EntityFrameworkCore;
using SellingElectronicWebsite.Entities;
using SellingElectronicWebsite.Helper;
using SellingElectronicWebsite.Model;
using SellingElectronicWebsite.ViewModel;
using System.Text.RegularExpressions;

namespace SellingElectronicWebsite.Repository
{
    public class AddressBookRepository : IAddressBookRepository
    {
        private SellingElectronicsContext _context;
        private readonly IMapper _mapper;


        public AddressBookRepository(SellingElectronicsContext context, IMapper mapper)
        {
            _context = context;
            _mapper = mapper;

        }
        public async Task<bool> Add(AddressBookModel model)
        {
            var checkPhoneNumber = Regex.IsMatch(model.PhoneNumber, @"^\d{10}$");
            if (checkPhoneNumber == false)
            {
                throw new Exception("Phone number is invalid!");
            }
            var checkCustomerExist = await _context.Customers.Where(p => p.CustomerId == model.CustomerId).FirstOrDefaultAsync();
            if (checkCustomerExist == null)
            {
                throw new Exception("Customer don't exist by id customer: " + model.CustomerId);

            }
            var newAddressBook = _mapper.Map<AddressCustomer>(model);
            await _context.AddAsync(newAddressBook);
            return true;
        }

        public async Task<bool> Delete(int idAddressbook)
        {
            var addressbook = await _context.AddressCustomers.Where(p => p.AddressCusId == idAddressbook).FirstOrDefaultAsync();
            if (addressbook == null)
            {
                throw new Exception("Address don't exist by id: " + idAddressbook);
            }
            _context.Remove(addressbook);
            return true;

        }

        public async Task<List<AddressBookVM>> GetByPage(int pageIndex, int pageSize)
        {
            var listAddressbook = await _context.AddressCustomers.ToListAsync();

            var queryable = _mapper.Map<List<AddressBookVM>>(listAddressbook).AsQueryable();
            var items = PaginatedList<AddressBookVM>.create(queryable, pageIndex, pageSize);
            return items;
        }

        public async Task<List<AddressBookVM>> GetAllByIdCustomer(int id)
        {
            var listAddressbook = await _context.AddressCustomers.Where(p => p.CustomerId == id).ToListAsync();
            return _mapper.Map<List<AddressBookVM>>(listAddressbook);
    }

        public async Task<AddressBookVM> GetByIdAddressBook(int id)
        {
            var addressbook = await _context.AddressCustomers.Where(p => p.AddressCusId == id).FirstOrDefaultAsync();
            return _mapper.Map<AddressBookVM>(addressbook);
        }

        public async Task<bool> Update(AddressBookModel model, int idAddressbook)
        {
            var checkPhoneNumber = Regex.IsMatch(model.PhoneNumber, @"^\d{10}$");
            if (checkPhoneNumber == false)
            {
                throw new Exception("Phone number is invalid!");
            }
            var addressbook = await _context.AddressCustomers.Where(p => p.AddressCusId == idAddressbook).FirstOrDefaultAsync();
            if(addressbook == null)
            {
                throw new Exception("Address don't exist by id: " + idAddressbook);
            }

            _mapper.Map(model, addressbook);
            _context.Update(model);
            return true;
        }

        public async Task<int> GetCountAddress()
        {
            var count = await _context.AddressCustomers.CountAsync();
            return count;
        }
    }
}
