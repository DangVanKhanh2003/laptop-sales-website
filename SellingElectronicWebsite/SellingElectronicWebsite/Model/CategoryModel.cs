namespace SellingElectronicWebsite.Model
{
    public class CategoryModel
    {

        public string? CategoryName { get; set; }
        public string? CategoryIcon { get; set; }
        public CategoryModel(string? categoryName, string? categoryIcon)
        {
            CategoryName = categoryName;
            CategoryIcon = categoryIcon;
        }
    }
}
