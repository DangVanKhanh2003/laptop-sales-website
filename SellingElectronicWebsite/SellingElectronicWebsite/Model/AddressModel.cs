namespace SellingElectronicWebsite.Model
{
    public class AddressModel
    {
        public string Province { get; set; } = null!;

        public string District { get; set; } = null!;

        public string Commune { get; set; } = null!;

        public string Street { get; set; } = null!;

        public string NumberHouse { get; set; } = null!;

        public AddressModel(string province, string district, string commune, string street, string numberHouse)
        {
            Province = province;
            District = district;
            Commune = commune;
            Street = street;
            NumberHouse = numberHouse;
        }
    }
}
