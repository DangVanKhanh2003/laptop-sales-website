namespace SellingElectronicWebsite.Model
{
    public class ProductOrderModel
    {

        public int? ProductId { get; set; }

        public int Amount { get; set; }

        public int? ColorId { get; set; }

        public ProductOrderModel(int? productId, int amount)
        {
            this.ProductId = productId;
            this.Amount = amount;
        }

        public ProductOrderModel()
        {

        }
    }
}
