namespace SellingElectronicWebsite.Model
{
    public class CustomerAccountModel
    {
        public int CustomerId { get; set; }

        public string Password { get; set; } = null!;
        public string Email { get; set; } = null!;


        public CustomerAccountModel(int CustomerId, string Password, string Email)
        {
            this.CustomerId = CustomerId;
            this.Password = Password;
            this.Email = Email;
        }
    }
}
