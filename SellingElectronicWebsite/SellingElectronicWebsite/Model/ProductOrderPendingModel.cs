namespace SellingElectronicWebsite.Model
{
    public class ProductOrderPendingModel
    {
        public int? ProductId { get; set; }

        public int Amount { get; set; }

        public int ColorId { get; set; }

        public ProductOrderPendingModel(int? productId, int amount, int colorId)
        {
            ProductId = productId;
            Amount = amount;
            ColorId = colorId;
        }
    }
}
