namespace SellingElectronicWebsite.ViewModel
{
    public class StoreProductVM
    {
        public StoreVM Store { get; set; }

        public ProductVM Product { get; set; }

        public int? Amount { get; set; }

        public ColorVM Color { get; set; }
        public StoreProductVM() { }
        public StoreProductVM(StoreVM store, ProductVM product, int? amount, ColorVM color)
        {
            Store = store;
            Product = product;
            Amount = amount;
            Color = color;
        }
    }
}
