using AutoMapper;
using Microsoft.EntityFrameworkCore;
using SellingElectronicWebsite.Entities;
using SellingElectronicWebsite.Model;
using SellingElectronicWebsite.ViewModel;

namespace SellingElectronicWebsite.Repository
{
    public class StoreRepository : IStoreRepository
    {
        private SellingElectronicsContext _context;
        private readonly IMapper _mapper;


        public StoreRepository(SellingElectronicsContext context, IMapper mapper)
        {
            _context = context;
            _mapper = mapper;

        }
        public async Task<bool> AddStore(Store model)
        {
           
            await _context.Stores.AddAsync(model);
            return true;
        }

        public async Task<int> DeleteStore(int idStore)
        {
            var item = await _context.Stores.Where(s => s.StoreId == idStore).FirstOrDefaultAsync();
            if (item != null)
            {
                var idItem = item.StoreId;

                _context.Stores.Remove(item);
                return idItem;
            }
            return -1;
        }
        public async Task<AddressVM> getAddressByStoreId(int storeId)
        {
            var item = await _context.Stores.Where(s => s.StoreId == storeId).FirstOrDefaultAsync();
            Address address = await _context.Addresses.Where(a => a.AddressId == item.AddressId).FirstOrDefaultAsync();

            return _mapper.Map< AddressVM>(address);
        }
        public async Task<List<StoreVM>> GetAllStore()
        {
            var Stores = await _context.Stores.ToListAsync();
            var StoresVM = _mapper.Map<List<StoreVM>>(Stores);
            foreach (var item in StoresVM)
            {
                AddressVM address = await getAddressByStoreId(item.StoreId);
                if (address != null)
                {
                    item.Address = address;
                }
            }
            return StoresVM;
        }

        public async Task<StoreVM> GetStoreById(int idStore)
        {
            var item = await _context.Stores.Where(s => s.StoreId == idStore).FirstOrDefaultAsync();
            var StoreVM = _mapper.Map<StoreVM>(item);
            AddressVM address = await getAddressByStoreId(item.StoreId);
            if (address != null)
            {
                StoreVM.Address = address;
            }
            return StoreVM;
        }

        public async Task<StoreVM> GetStoreByName(string nameStore)
        {
            var item = await _context.Stores.Where(c => c.StoreName.Equals(nameStore)).FirstOrDefaultAsync();
            var itemVM = _mapper.Map<StoreVM>(item);
            return itemVM;
        }

        public async Task<bool> UpdateStore(StoreModel model, int idStore)
        {
            var item = await _context.Stores.Where(c => c.StoreId.Equals(idStore)).FirstOrDefaultAsync();
            if (item == null)
            {
                return false;
            }
            var itemAddress = _mapper.Map<Address>(model.Address);
            var address = await _context.Addresses.Where(c => c.AddressId.Equals(item.AddressId)).FirstOrDefaultAsync();
            await _context.Addresses.AddAsync(itemAddress);
            _context.Update(address);
            item.StoreName = model.StoreName;
            _context.Update(item);
            return true;
        }
    }
}
