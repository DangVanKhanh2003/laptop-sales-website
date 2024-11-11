namespace SellingElectronicWebsite.Model
{
    public class ShoppingCartItemModel
    {
        public int CustomerId { get; set; }

        public int ProductId { get; set; }

        public int Amount { get; set; }

        public int ColorId { get; set; }

        public ShoppingCartItemModel(int customerId, int productId, int amount, int colorId)
        {
            CustomerId = customerId;
            ProductId = productId;
            Amount = amount;
            ColorId = colorId;
        }
    }
}
