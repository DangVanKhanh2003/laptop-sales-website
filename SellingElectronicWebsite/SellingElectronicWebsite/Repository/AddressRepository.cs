using AutoMapper;
using Microsoft.EntityFrameworkCore;
using SellingElectronicWebsite.Entities;
using SellingElectronicWebsite.Model;
using SellingElectronicWebsite.ViewModel;

namespace SellingElectronicWebsite.Repository
{
    public class AddressRepository: IAddressesRepository
    {
        private SellingElectronicsContext _context;
        private readonly IMapper _mapper;


        public AddressRepository(SellingElectronicsContext context, IMapper mapper)
        {
            _context = context;
            _mapper = mapper;

        }
        public async Task<Address> Add(AddressModel model)
        {
            var item = _mapper.Map<Address>(model);
            await _context.Addresses.AddAsync(item);
            return item;
        }

        public async Task<bool> Delete(int id)
        {
            var item = await _context.Addresses.FindAsync(id);
            if (item != null)
            {
                _context.Remove(item);
                return true;
            }
            return false;
        }

        public async Task<List<AddressVM>> GetAll()
        {
            var items = await _context.Addresses.ToListAsync();
            var AddresssVM = _mapper.Map<List<AddressVM>>(items);
            return AddresssVM;
        }

        public async Task<AddressVM> GetById(int id)
        {
            var item = await _context.Addresses.FindAsync(id);
            var AddressVM = _mapper.Map<AddressVM>(item);
            return AddressVM;
        }


        public async Task<bool> Update(AddressModel model, int id)
        {
            var item = await _context.Addresses.Where(c => c.AddressId.Equals(id)).FirstOrDefaultAsync();
            if (item == null)
            {
                return false;
            }
            _mapper.Map(model, item);
            _context.Update(item);
            return true;
        }
    }
}
