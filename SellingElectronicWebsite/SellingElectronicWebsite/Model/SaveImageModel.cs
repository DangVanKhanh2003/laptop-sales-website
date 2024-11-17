namespace SellingElectronicWebsite.Model
{

    public class SaveImageModel
    {
        public string Base64Image { get; set; } // Base64-encoded image string
        public string FileName { get; set; }    // File name
        public string Extension { get; set; }   // File extension (e.g., .jpg, .png)
    }
}
