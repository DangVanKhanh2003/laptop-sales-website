using SellingElectronicWebsite.Entities;

namespace SellingElectronicWebsite.Model
{
    public class StoreModel
    {

        public string? StoreName { get; set; }

        public  AddressModel Address { get; set; }

        public StoreModel(string? storeName, AddressModel address)
        {
            StoreName = storeName;
            Address = address;
        }
    }
}
