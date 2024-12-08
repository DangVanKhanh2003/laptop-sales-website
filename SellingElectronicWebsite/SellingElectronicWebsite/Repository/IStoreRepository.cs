using SellingElectronicWebsite.Entities;
using SellingElectronicWebsite.Model;
using SellingElectronicWebsite.ViewModel;

namespace SellingElectronicWebsite.Repository
{
    public interface IStoreRepository
    {
        Task<List<StoreVM>> GetAllStore();
        Task<StoreVM> GetStoreById(int idStore);
        Task<StoreVM> GetStoreByName(string nameStore);
        Task<bool> AddStore(Store model);
        Task<bool> UpdateStore(StoreModel model, int idStore);
        Task<int> DeleteStore(int idStore);

        Task<List<StoreProductVM>> GetAllProductByIdStore(int idStore);
        Task<StoreProductVM> GetProductByIdStore(int idStore, int idProduct);
        Task<List<StoreProductVM>> GetStoreExistProduct(int idProduct);
        Task<StoreProductVM> AddStoreProduct(int idProduct, int idStore, int amountAdd, int idColor);
        Task<StoreProductVM> ReduceStoreProduct(int idProduct, int idStore, int amountReduce, int idColor);
        Task<StoreProductVM> UpdateAmountStoreProduct(int idProduct, int idStore, int amount, int idColor);

    }
}
