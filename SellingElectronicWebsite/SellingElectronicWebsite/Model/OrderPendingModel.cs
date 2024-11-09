namespace SellingElectronicWebsite.Model
{
    public class OrderPendingModel
    {
        public int? CustomerId { get; set; }

        public List<ProductOrderPendingModel> ListProductOrederPending { get; set; }

        public OrderPendingModel(int? customerId, List<ProductOrderPendingModel> listProductOrederPending)
        {
            CustomerId = customerId;
            ListProductOrederPending = listProductOrederPending;
        }
    }
}
