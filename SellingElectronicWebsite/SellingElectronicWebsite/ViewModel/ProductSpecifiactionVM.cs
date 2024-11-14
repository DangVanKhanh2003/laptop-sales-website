namespace SellingElectronicWebsite.ViewModel
{
    public class ProductSpecifiactionVM
    {
        public int SpecifiactionsId { get; set; }

        public string SpecType { get; set; } = null!;

        public string Description { get; set; } = null!;

        public int ProductId { get; set; }

        public ProductSpecifiactionVM() { }
        public ProductSpecifiactionVM(int specifiactionsId, string specType, string description, int productId)
        {
            SpecifiactionsId = specifiactionsId;
            SpecType = specType;
            Description = description;
            ProductId = productId;
        }
    }
}
