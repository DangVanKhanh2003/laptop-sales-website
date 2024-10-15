namespace SellingElectronicWebsite.Model
{
    public class CategoryModel
    {

        public string? CategoryName { get; set; }

        public CategoryModel(string? categoryName)
        {
            CategoryName = categoryName;
        }
    }
}
