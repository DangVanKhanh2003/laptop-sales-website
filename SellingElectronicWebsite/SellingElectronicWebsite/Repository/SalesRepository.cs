using AutoMapper;
using Microsoft.EntityFrameworkCore;
using SellingElectronicWebsite.Entities;
using SellingElectronicWebsite.Model;
using SellingElectronicWebsite.ViewModel;

namespace SellingElectronicWebsite.Repository
{
    public class SalesRepository : ISalesRepository
    {
        private SellingElectronicsContext _context;
        private readonly IMapper _mapper;


        public SalesRepository(SellingElectronicsContext context, IMapper mapper)
        {
            _context = context;
            _mapper = mapper;

        }
        public async Task<bool> checkProductExist(int productId)
        {
            var checkProduct = await _context.Products.Where(p => p.ProductId == productId).FirstOrDefaultAsync();
            if(checkProduct == null)
            {
                return false;
            }
            return true;
        }
        public async Task<bool> Add(SalesModel model)
        {

            //check time sale conflict
            var checkTimeConflict = await _context.Sales.Where(s => model.StartAt <= s.EndAt && model.EndAt >= s.StartAt && s.ProductId == model.ProductId).FirstOrDefaultAsync();
            if (checkTimeConflict != null)
            {
                return false;
            }
            var item = _mapper.Map<Sale>(model);
            await _context.Sales.AddAsync(item);
            return true;
        }

        public async Task<bool> Delete(int id)
        {
            var item = await _context.Sales.Where(s => s.SaleId == id).FirstOrDefaultAsync();
            if (item != null)
            {
                _context.Remove(item);
                return true;
            }
            return false;
        }

        public async Task<List<SalesVM>> GetAll()
        {
            var Sales = await _context.Sales.ToListAsync();
            var SalesVM = _mapper.Map<List<SalesVM>>(Sales);
            return SalesVM;
        }

        public async Task<SalesVM> GetById(int id)
        {
            var item = await _context.Sales.Where(s => s.SaleId == id).FirstOrDefaultAsync();
            var SaleVM = _mapper.Map<SalesVM>(item);
            return SaleVM;
        }


        public async Task<bool> Update(SalesModel model, int id)
        {
            //check time sale conflict
            var checkTimeConflict = await _context.Sales.Where(s => model.StartAt <= s.EndAt && model.EndAt >= s.StartAt && s.SaleId != id && s.ProductId == model.ProductId).FirstOrDefaultAsync();
            if (checkTimeConflict != null)
            {
                return false;
            }
            var item = await _context.Sales.Where(c => c.SaleId.Equals(id)).FirstOrDefaultAsync();
            _mapper.Map(model, item);
            _context.Update(item);
            return true;
        }

        public async Task<List<SalesVM>> GetByIdProduct(int idProduct)
        {

            var items = await _context.Sales.Where(s => s.ProductId == idProduct).ToListAsync();
            if(items != null)
            {
                var itemsVM = _mapper.Map<List<SalesVM>>(items);
                return itemsVM;
            }
            return null;
        }

        public async Task<bool> DeleteByIdProduct(int idProduct)
        {
            var items = await _context.Sales.Where(s => s.ProductId == idProduct).ToListAsync();
            if(items.Count() == 0) { return false; }
            foreach(var item in items)
            {
                _context.Sales.Remove(item);
            }
            return true;
        }
    }
}
