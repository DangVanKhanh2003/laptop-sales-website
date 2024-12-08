using SellingElectronicWebsite.Model;
using SellingElectronicWebsite.ViewModel;

namespace SellingElectronicWebsite.Repository
{
    public interface IShoppingCartRepository
    {
        Task<List<ShoppingCartItemVM>> GetByIdCustomer(int idCustomer);
        Task<bool> Add(ShoppingCartItemModel model);
        Task<bool> UpdateAmount(int amount, int idShoppingCart);
        Task<bool> Delete(int idShoppingCart);
        Task<bool> DeleteAllByIdCustomer(int idCustomer);
    }
}
