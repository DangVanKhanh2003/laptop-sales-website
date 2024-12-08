namespace SellingElectronicWebsite.Model
{
    public class AddressBookModel
    {
        public string Province { get; set; } = null!;

        public string District { get; set; } = null!;

        public string Commune { get; set; } = null!;

        public string Street { get; set; } = null!;

        public string NumberHouse { get; set; } = null!;

        public string PhoneNumber { get; set; } = null!;

        public int? CustomerId { get; set; }

        public AddressBookModel(string province, string district, string commune, string street, string numberHouse, string phoneNumber, int? customerId)
        {
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
