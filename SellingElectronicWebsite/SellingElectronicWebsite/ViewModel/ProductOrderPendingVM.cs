namespace SellingElectronicWebsite.ViewModel
{
    public class ProductOrderPendingVM
    {
        public int ProductOrderPendingId { get; set; }

        public int ProductId { get; set; }

        public string ProductName { get; set; }

        public int Amount { get; set; }

        public string ColorName { get; set; }

        public string Brand { get; set; } = null!;

        public string Series { get; set; } = null!;

        public decimal Price { get; set; }

        public string CategoryName { get; set; }
        public string? MainImg { get; set; }

        public SalesVM sale { get; set; }

        public ProductOrderPendingVM() { }
        public ProductOrderPendingVM(int productOrderPendingId, int productId, string productName, int amount, string colorName, string brand, string series, decimal price, string categoryName, string? mainImg, SalesVM sale)
        {
            ProductOrderPendingId = productOrderPendingId;
            ProductId = productId;
            ProductName = productName;
            Amount = amount;
            ColorName = colorName;
            Brand = brand;
            Series = series;
            Price = price;
            CategoryName = categoryName;
            MainImg = mainImg;
            this.sale = sale;
        }

        public ProductOrderPendingVM(int productOrderPendingId, int productId, string productName, 
            int amount, string colorName, string brand, string series,
            decimal price, string categoryName, string? mainImg)
        {
            ProductOrderPendingId = productOrderPendingId;
            ProductId = productId;
            ProductName = productName;
            Amount = amount;
            ColorName = colorName;
            Brand = brand;
            Series = series;
            Price = price;
            CategoryName = categoryName;
            MainImg = mainImg;
        }
    }
}
