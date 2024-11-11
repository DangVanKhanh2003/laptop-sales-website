using SellingElectronicWebsite.Entities;

namespace SellingElectronicWebsite.ViewModel
{
    public class StoreVM
    {

        public int StoreId { get; set; }

        public string? StoreName { get; set; }


        public  AddressVM Address { get; set; }
        public StoreVM() { }
        public StoreVM (int storeId, string? storeName, AddressVM address)
        {
            StoreId = storeId;
            StoreName = storeName;
            Address = address;
        }
    }
}
