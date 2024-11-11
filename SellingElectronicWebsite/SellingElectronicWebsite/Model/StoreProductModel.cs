namespace SellingElectronicWebsite.Model
{
    public class StoreProductModel
    {
        public int? StoreId { get; set; }

        public int? ProductId { get; set; }

        public int? Amount { get; set; }

        public int? ColorId { get; set; }

        public StoreProductModel(int? storeId, int? productId, int? amount, int? colorId)
        {
            StoreId = storeId;
            ProductId = productId;
            Amount = amount;
            ColorId = colorId;
        }
    }
}
