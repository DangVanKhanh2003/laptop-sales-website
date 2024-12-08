using SellingElectronicWebsite.Entities;
using SellingElectronicWebsite.Model;
using SellingElectronicWebsite.ViewModel;

namespace SellingElectronicWebsite.Repository
{
    public interface IAddressesRepository
    {
        Task<List<AddressVM>> GetAll();
        Task<AddressVM> GetById(int id);
        Task<Address> Add(AddressModel model);
        Task<bool> Update(AddressModel model, int id);
        Task<bool> Delete(int id);
    }
}
