namespace SellingElectronicWebsite.ViewModel
{
    public class CategoryVM
    {
        public int CategoryId { get; set; }

        public string? CategoryName { get; set; }
        public string? CategoryIcon { get; set; }
        public CategoryVM(int categoryId, string categoryName, string? categoryIcon)
        {
            CategoryId = categoryId;
            CategoryName = categoryName;
            CategoryIcon = categoryIcon;
        }
    }
}
