namespace SellingElectronicWebsite.Model
{
    public class SalesModel
    {
        public int ProductId { get; set; }

        public int? NumProduct { get; set; }

        public DateTime StartAt { get; set; }

        public DateTime EndAt { get; set; }

        public int PercentSale { get; set; }


        public SalesModel(int productId, int? numProduct, DateTime startAt, DateTime endAt, int percentSale)
        {
            ProductId = productId;
            NumProduct = numProduct;
            StartAt = startAt;
            EndAt = endAt;
            PercentSale = percentSale;
        }
    }
}
