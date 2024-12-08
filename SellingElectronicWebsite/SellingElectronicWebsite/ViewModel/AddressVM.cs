namespace SellingElectronicWebsite.ViewModel
{
    public class AddressVM
    {
        public int AddressId { get; set; }

        public string Province { get; set; } = null!;

        public string District { get; set; } = null!;

        public string Commune { get; set; } = null!;

        public string Street { get; set; } = null!;

        public string NumberHouse { get; set; } = null!;

        public AddressVM(int addressId, string province, string district, string commune, string street, string numberHouse)
        {
            AddressId = addressId;
            Province = province;
            District = district;
            Commune = commune;
            Street = street;
            NumberHouse = numberHouse;
        }
    }
}
