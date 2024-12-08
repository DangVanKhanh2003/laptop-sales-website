using AutoMapper;
using Microsoft.EntityFrameworkCore;
using SellingElectronicWebsite.Entities;
using SellingElectronicWebsite.Model;
using SellingElectronicWebsite.ViewModel;

namespace SellingElectronicWebsite.Repository
{
    public class ColorsRepository : IColorsRepository
    {
        private SellingElectronicsContext _context;
        private readonly IMapper _mapper;


        public ColorsRepository(SellingElectronicsContext context, IMapper mapper)
        {
            _context = context;
            _mapper = mapper;

        }
        public async Task<bool> Add(ColorModel model)
        {
            var item = _mapper.Map<Color>(model);
            await _context.Colors.AddAsync(item);
            return true;
        }

        public async Task<bool> Delete(int id)
        {
            var item = await _context.Colors.Where(s => s.ColorId == id).FirstOrDefaultAsync();
            if (item != null)
            {
                _context.Remove(item);
                return true;
            }
            return false;
        }

        public async Task<List<ColorVM>> GetAll()
        {
            var colors = await _context.Colors.ToListAsync();
            var colorsVM = _mapper.Map<List<ColorVM>>(colors);
            return colorsVM;
        }

        public async Task<ColorVM> GetById(int id)
        {
            var item = await _context.Colors.Where(s => s.ColorId == id).FirstOrDefaultAsync();
            var colorVM = _mapper.Map<ColorVM>(item);
            return colorVM;
        }
        public async Task<ColorVM> GetByName(string name)
        {
            var item = await _context.Colors.Where(c => c.ColorName.Equals(name)).FirstOrDefaultAsync();
            var itemVM = _mapper.Map<ColorVM>(item);    
            return itemVM;
        }

        public async Task<bool> Update(ColorModel model, int id)
        {
            var item = await _context.Colors.Where(c => c.ColorId.Equals(id)).FirstOrDefaultAsync();
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
