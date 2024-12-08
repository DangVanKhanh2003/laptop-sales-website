namespace SellingElectronicWebsite.ViewModel
{
    public class ProductOrderVM
    {
        public int ProductOrderId { get; set; }

        public int? OrderId { get; set; }

        public ProductVM Product { get; set; }

        public int Amount { get; set; }

        public ColorVM Color { get; set; }

        public decimal? UntilPrice { get; set; }

        public ProductOrderVM() { }
        public ProductOrderVM(int productOrderId, int? orderId, ProductVM product, int amount, ColorVM color, decimal? untilPrice)
        {
            ProductOrderId = productOrderId;
            OrderId = orderId;
            Product = product;
            Amount = amount;
            Color = color;
            UntilPrice = untilPrice;
        }
    }
}
