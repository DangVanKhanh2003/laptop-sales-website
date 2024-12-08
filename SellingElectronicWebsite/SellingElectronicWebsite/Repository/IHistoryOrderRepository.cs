using SellingElectronicWebsite.ViewModel;

namespace SellingElectronicWebsite.Repository
{
    public interface IHistoryOrderRepository
    {
        Task<List<CancelOrderVM>> GetAllCancelOrderByIdCustomer (int idCustomer, string sortByOrderDate);
        Task<List<OrderVM>> GetAllSuccessOrderByIdCustomer (int idCustomer, string sortByOrderDate);
    }
}
