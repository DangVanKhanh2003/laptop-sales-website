namespace SellingElectronicWebsite.ViewModel
{
    public class CustomerVM
    {
        public int CustomerId { get; set; }

        public string? FullName { get; set; }

        public string? PhoneNumber { get; set; }

        public AddressVM Address { get; set; }

        public CustomerVM(int customerId, string? fullName, string? phoneNumber, AddressVM address)
        {
            CustomerId = customerId;
            FullName = fullName;
            PhoneNumber = phoneNumber;
            Address = address;
        }
    }
}
