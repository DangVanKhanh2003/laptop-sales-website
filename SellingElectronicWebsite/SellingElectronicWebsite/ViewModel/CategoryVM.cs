namespace SellingElectronicWebsite.ViewModel
{
    public class CategoryVM
    {
        public int CategoryId { get; set; }

        public string? CategoryName { get; set; }

        public CategoryVM(int categoryId, string categoryName)
        { 
            CategoryId = categoryId; 
            CategoryName = categoryName;
        }
    }
}
