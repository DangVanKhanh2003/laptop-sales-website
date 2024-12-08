using AutoMapper;
using Microsoft.EntityFrameworkCore;
using SellingElectronicWebsite.Entities;
using SellingElectronicWebsite.Model;
using SellingElectronicWebsite.ViewModel;

namespace SellingElectronicWebsite.Repository
{
    public class CategoryRepository : ICategoryRepository
    {
        private SellingElectronicsContext _context;
        private readonly IMapper _mapper;


        public CategoryRepository(SellingElectronicsContext context, IMapper mapper)
        {
            _context = context;
            _mapper = mapper;

        }
        public async Task<bool> Add(CategoryModel model)
        {
            var item = _mapper.Map<Category>(model);
            await _context.Categories.AddAsync(item);
            return true;
        }

        public async Task<bool> Delete(int id)
        {
            var item = await _context.Categories.FindAsync(id);
            if(item != null)
            {
                _context.Remove(item);
                return true;
            }
            return false;
        }

        public async Task<List<CategoryVM>> GetAll()
        {
            var items = await _context.Categories.ToListAsync();
            var CategorysVM = _mapper.Map<List<CategoryVM>>(items);
            return CategorysVM;
        }

        public async Task<CategoryVM> GetById(int id)
        {
            var item = await _context.Categories.FindAsync(id);
            var CategoryVM = _mapper.Map<CategoryVM>(item);
            return CategoryVM;
        }

        public async Task<CategoryVM> GetByName(string name)
        {
            var item = await _context.Categories.Where(c => c.CategoryName.Equals(name)).FirstOrDefaultAsync();
            var itemVM = _mapper.Map<CategoryVM>(item);
            return itemVM;
        }

        public async Task<bool> Update(CategoryModel model, int id)
        {
            var item = await _context.Categories.Where(c => c.CategoryId.Equals(id)).FirstOrDefaultAsync();
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
