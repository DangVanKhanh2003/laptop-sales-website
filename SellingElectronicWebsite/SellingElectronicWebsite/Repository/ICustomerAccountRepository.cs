using SellingElectronicWebsite.Entities;
using SellingElectronicWebsite.Model;
using SellingElectronicWebsite.ViewModel;

namespace SellingElectronicWebsite.Repository
{
    public interface ICustomerAccountRepository
    {
        Task<List<CustomerAccountVM>> GetAll();
        Task<List<CustomerAccountVM>> GetByPage(int pageIndex, int pageSize);

        Task<CustomerAccountVM> GetByIdCustomer(int id);
        Task<bool> Register(CustomerAccountModel model);
        Task<string> CheckLogin(string email, string password);
        Task<bool> ChangePassword(string email, string password, string newPassword);
        Task<bool> DeleteAccountByIdCustomer(int id);
    }
}
