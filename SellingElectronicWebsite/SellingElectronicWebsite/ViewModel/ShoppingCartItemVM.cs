namespace SellingElectronicWebsite.ViewModel
{
    public class ShoppingCartItemVM
    {
        public int ShoppingCartItemId { get; set; }

        public int CustomerId { get; set; }

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

        public ShoppingCartItemVM() { }
        public ShoppingCartItemVM(int shoppingCartId, int productId, int customerId, string productName, int amount, string colorName, string brand, string series, decimal price, string categoryName, string? mainImg)
        {
            ShoppingCartItemId = shoppingCartId;
            CustomerId = customerId;
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
