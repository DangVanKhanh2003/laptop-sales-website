using SellingElectronicWebsite.Model;
using SellingElectronicWebsite.ViewModel;

namespace SellingElectronicWebsite.Repository
{
    public interface IOrderRepository
    {

        Task<List<OrderVM>> GetAll(string status, string sortByOrderDate);
        Task<List<OrderVM>> GetAllPaging(string status, string sortByOrderDate, int pageIndex, int pageSize);
        Task<List<OrderVM>> GetByIdStorePaging(string status, string sortByOrderDate, int idStore, int pageIndex, int pageSize);
        Task<List<OrderVM>> GetByIdStore(string status, string sortByOrderDate, int idStore);
        Task<OrderVM> GetByIdOrder(int idOrder);
        Task<List<OrderVM>> GetByIdCustomer(int idCustomer, string status);
        Task<OrderVM> OderOffline(OrderOfflineModel model);
        Task<OrderVM> ExportOrder(int idOrder, int employeeId);
        Task<OrderVM> CancelOrder(int idOrder, int employeeId);

        
    }
}
