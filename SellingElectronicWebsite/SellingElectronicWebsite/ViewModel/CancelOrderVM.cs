namespace SellingElectronicWebsite.ViewModel
{
    public class CancelOrderVM
    {
      
        public DateTime? OdertDate { get; set; }
        public string ActorCancel { get; set; } = null!;
        public List<ProductOrderCancelVM> CancelProducts { get; set; }

        public CancelOrderVM() { }

        

    }
}
