namespace SellingElectronicWebsite.Model
{
    public class ProductSpecifiactionModel
    {
        public string SpecType { get; set; } = null!;

        public string Description { get; set; } = null!;

        public int ProductId { get; set; }

        public ProductSpecifiactionModel(string specType, string description, int productId)
        {
            SpecType = specType;
            Description = description;
            ProductId = productId;
        }
    }
}
