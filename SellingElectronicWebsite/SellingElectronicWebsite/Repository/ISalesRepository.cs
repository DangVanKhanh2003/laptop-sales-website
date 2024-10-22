using SellingElectronicWebsite.Model;
using SellingElectronicWebsite.ViewModel;

namespace SellingElectronicWebsite.Repository
{
    public interface ISalesRepository
    {
        Task<List<SalesVM>> GetAll();
        Task<List<SalesVM>> GetByIdProduct(int idProduct);
        Task<SalesVM> GetById(int id);
        Task<bool> Add(SalesModel model);
        Task<bool> Update(SalesModel model, int id);
        Task<bool> Delete(int id);
        Task<bool> DeleteByIdProduct(int idProduct);
    }
}
