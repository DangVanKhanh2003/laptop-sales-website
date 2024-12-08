namespace SellingElectronicWebsite.ViewModel
{
    public class ProductOrderCancelVM
    {
        public ProductVM Product { get; set; }

        public int Amount { get; set; }

        public ColorVM Color { get; set; }

        public decimal? UntilPrice { get; set; }

        public ProductOrderCancelVM()
        {

        }

    }
}
