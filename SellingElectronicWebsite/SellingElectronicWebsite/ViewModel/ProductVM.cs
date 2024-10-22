using SellingElectronicWebsite.Entities;
namespace SellingElectronicWebsite.ViewModel
{
    public class ProductVM
    {
        public int ProductId { get; set; }

        public string ProductName { get; set; } = null!;

        public string Brand { get; set; } = null!;

        public string Series { get; set; } = null!;

        public decimal Price { get; set; }

        public string CategoryName { get; set; }
        public string? MainImg { get; set; }

       public SalesVM sale {  get; set; }
        public ProductVM() {
            sale = null;
        }
        public ProductVM(int productId, string productName, string brand, string series, decimal price, 
            string? categoryName, string? mainImg)
        {
            ProductId = productId;
            ProductName = productName;
            Brand = brand;
            Series = series;
            Price = price;
            CategoryName = categoryName;
            MainImg = mainImg; 
            sale = null;

        }
    }
}
