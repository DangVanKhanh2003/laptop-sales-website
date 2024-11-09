namespace SellingElectronicWebsite.ViewModel
{
    public class AddressBookVM
    {
        public int AddressCusId { get; set; }

        public string Province { get; set; } = null!;

        public string District { get; set; } = null!;

        public string Commune { get; set; } = null!;

        public string Street { get; set; } = null!;

        public string NumberHouse { get; set; } = null!;

        public string PhoneNumber { get; set; } = null!;

        public int? CustomerId { get; set; }
            
        public AddressBookVM(int addressCusId, string province, string district, string commune, string street, string numberHouse, string phoneNumber, int? customerId)
        {
            AddressCusId = addressCusId;
            Province = province;
            District = district;
            Commune = commune;
            Street = street;
            NumberHouse = numberHouse;
            PhoneNumber = phoneNumber;
            CustomerId = customerId;
        }
    }
}
