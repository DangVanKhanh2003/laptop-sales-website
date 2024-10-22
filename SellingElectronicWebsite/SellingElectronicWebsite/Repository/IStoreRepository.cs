using SellingElectronicWebsite.Model;
using SellingElectronicWebsite.ViewModel;

namespace SellingElectronicWebsite.Repository
{
    public interface IStoreRepository
    {
        Task<List<StoreVM>> GetAllStore();
        Task<StoreVM> GetStoreById(int idStore);
        Task<StoreVM> GetStoreByName(string nameStore);
        Task<bool> AddStore(StoreModel model);
        Task<bool> UpdateStore(StoreModel model, int idStore);
        Task<bool> DeleteStore(int idStore);
    }
}
