namespace SellingElectronicWebsite.ViewModel
{
    public class ColorVM
    {
        public int ColorId { get; set; }

        public string ColorName { get; set; }
        public ColorVM() { }
        public ColorVM(int ColorId, string? ColorName)
        {
            this.ColorId = ColorId;
            this.ColorName = ColorName; 
        }
    }
}
