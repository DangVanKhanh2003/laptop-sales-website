using SellingElectronicWebsite.Entities;

namespace SellingElectronicWebsite.ViewModel
{
    public class CustomerAccountVM
    {
        public Guid AccCustomerId { get; set; }

        public int CustomerId { get; set; }
        public string Email { get; set; } = null!;

        public CustomerAccountVM(Guid accCustomerId, int customerId, string Email)
        {
            AccCustomerId = accCustomerId;
            CustomerId = customerId;
            this.Email = Email;

        }
    }
}
