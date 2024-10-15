using SellingElectronicWebsite.Model;
using SellingElectronicWebsite.ViewModel;

namespace SellingElectronicWebsite.Repository
{
    public interface ICategoryRepository
    {
        Task<List<CategoryVM>> GetAll();
        Task<CategoryVM> GetById(int id);
        Task<CategoryVM> GetByName(string name);
        Task<bool> Add(CategoryModel model);
        Task<bool> Update(CategoryModel model, int id);
        Task<bool> Delete(int id);
    }
}
