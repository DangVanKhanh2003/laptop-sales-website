using SellingElectronicWebsite.Model;
using SellingElectronicWebsite.ViewModel;

namespace SellingElectronicWebsite.Repository
{
    public interface IColorsRepository
    {
        Task<List<ColorVM>> GetAll();
        Task<ColorVM> GetById(int id);
        Task<ColorVM> GetByName(string name);
        Task<bool> Add(ColorModel model);
        Task<bool> Update(ColorModel model, int id);
        Task<bool> Delete(int id);
    }
}
