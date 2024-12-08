using SellingElectronicWebsite.Entities;
using SellingElectronicWebsite.Model;
using SellingElectronicWebsite.ViewModel;

namespace SellingElectronicWebsite.Repository
{
    public interface IAddressBookRepository
    {
        Task<List<AddressBookVM>> GetByPage(int pageIndex, int pageSize);
        Task<List<AddressBookVM>> GetAllByIdCustomer(int id);
        Task<AddressBookVM> GetByIdAddressBook(int id);
        Task<int> GetCountAddress();
        Task<bool> Add(AddressBookModel model);
        Task<bool> Update(AddressBookModel model, int idAddressbook);
        Task<bool> Delete(int id);
    }
}
