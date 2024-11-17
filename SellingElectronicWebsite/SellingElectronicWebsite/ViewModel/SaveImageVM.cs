namespace SellingElectronicWebsite.ViewModel
{
    public class SaveImageVM
    {
        public int id { get; set; }
        public string Base64Image { get; set; } // Base64-encoded image string
        public string FileName { get; set; }    // File name
        public string Extension { get; set; }   // File extension (e.g., .jpg, .png)


    }
}
