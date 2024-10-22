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
        public async Task<bool> AddStore(StoreModel model)
        {
            var item = _mapper.Map<Store>(model);
            await _context.Stores.AddAsync(item);
            return true;
        }

        public async Task<bool> DeleteStore(int idStore)
        {
            var item = await _context.Stores.Where(s => s.StoreId == idStore).FirstOrDefaultAsync();
            if (item != null)
            {
                _context.Remove(item);
                return true;
            }
            return false;
        }

        public async Task<List<StoreVM>> GetAllStore()
        {
            var Stores = await _context.Stores.ToListAsync();
            var StoresVM = _mapper.Map<List<StoreVM>>(Stores);
            return StoresVM;
        }

        public async Task<StoreVM> GetStoreById(int idStore)
        {
            var item = await _context.Stores.Where(s => s.StoreId == idStore).FirstOrDefaultAsync();
            var StoreVM = _mapper.Map<StoreVM>(item);
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
            _mapper.Map(model, item);
            _context.Update(item);
            return true;
        }
    }
}
