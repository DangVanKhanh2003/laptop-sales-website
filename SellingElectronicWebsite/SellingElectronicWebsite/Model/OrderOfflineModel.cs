using SellingElectronicWebsite.Entities;

namespace SellingElectronicWebsite.Model
{
    public class OrderOfflineModel
    {
        public int? CustomerId { get; set; }

        public int? EmployeeId { get; set; }


        public int? StoreId { get; set; }

        public List<ProductOrderModel> ListProductOrder { get; set; }

        public OrderOfflineModel()
        {

        }
        public OrderOfflineModel(int? customerId, int? employeeId, int? storeId, List<ProductOrderModel> listProductOrder)
        {
            CustomerId = customerId;
            EmployeeId = employeeId;
            StoreId = storeId;
            ListProductOrder = listProductOrder;
        }
    }
}
