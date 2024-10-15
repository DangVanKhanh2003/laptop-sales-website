namespace SellingElectronicWebsite.Model
{
    public class ImageProductsModel
    {
        public string ImgLink { get; set; } = null!;

        public int? ColorId { get; set; }

        public int ProductId { get; set; }

        public ImageProductsModel(string imgLink, int? colorId, int productId)
        {
            ImgLink = imgLink;
            ColorId = colorId;
            ProductId = productId;
        }
    }
}
