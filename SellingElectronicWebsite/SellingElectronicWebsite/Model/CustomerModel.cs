using SellingElectronicWebsite.ViewModel;

namespace SellingElectronicWebsite.Model
{
    public class CustomerModel
    {
        public string? FullName { get; set; }

        public string? PhoneNumber { get; set; }

        public AddressModel Address { get; set; }

        public CustomerModel( string? fullName, string? phoneNumber, AddressModel address)
        {
            FullName = fullName;
            PhoneNumber = phoneNumber;
            Address = address;
        }
    }
}
