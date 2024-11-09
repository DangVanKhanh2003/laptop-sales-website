using SellingElectronicWebsite.Model;
using SellingElectronicWebsite.ViewModel;

namespace SellingElectronicWebsite.Repository
{
    public interface IShoppingCartRepository
    {
        Task<List<ShoppingCartVM>> GetByIdCustomer(int idCustomer);
        Task<bool> Add(ShoppingCartModel model);
        Task<bool> UpdateAmount(int amount, int idShoppingCart);
        Task<bool> Delete(int idShoppingCart);
    }
}
