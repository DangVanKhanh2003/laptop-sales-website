namespace SellingElectronicWebsite.ViewModel
{
    public class ImageProductsVM
    {
        public int ImgId { get; set; }

        public string ImgLink { get; set; } = null!;

        public int? ColorId { get; set; }

        public int ProductId { get; set; }

        public ImageProductsVM(int imgId, string imgLink, int? colorId, int productId)
        {
            ImgId = imgId;
            ImgLink = imgLink;
            ColorId = colorId;
            ProductId = productId;
        }   
        
    }
}
