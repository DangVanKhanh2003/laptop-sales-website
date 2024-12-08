namespace SellingElectronicWebsite.ViewModel
{
    public class SalesVM
    {
        public int SaleId { get; set; }

        public int ProductId { get; set; }

        public int? NumProduct { get; set; }

        public DateTime StartAt { get; set; }

        public DateTime EndAt { get; set; }

        public int PercentSale { get; set; }

        public int? NumProductSold { get; set; }

        public SalesVM(int saleId, int productId, int? numProduct, DateTime startAt, DateTime endAt, int percentSale, int? numProductSold=null)
        {
            SaleId = saleId;
            ProductId = productId;
            NumProduct = numProduct;
            StartAt = startAt;
            EndAt = endAt;
            PercentSale = percentSale;
            NumProductSold = numProductSold;
        }
    }
}
