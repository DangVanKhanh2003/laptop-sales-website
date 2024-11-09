using SellingElectronicWebsite.Entities;
using SellingElectronicWebsite.Model;
using SellingElectronicWebsite.ViewModel;

namespace SellingElectronicWebsite.Repository
{
    public interface ICustomersRepository
    {
        Task<List<CustomerVM>> GetAll(string sortBy);
        Task<List<CustomerVM>> GetByPage(int pageIndex, int pageSize, string sortBy);
        Task<CustomerVM> GetById(int id);
        Task<bool> Add(CustomerModel model);
        Task<bool> Update(CustomerModel model, int id);
        Task<bool> DeleteByIdCustomer(int id);
    }
}
