using SellingElectronicWebsite.Repository;
namespace SellingElectronicWebsite.UnitOfWork
{
    public interface IUnitOfWork
    {
        //Define the Specific Repositories
        public ProductsRepository Products { get; }  
        public ColorsRepository Colors { get; }  
        public CategoryRepository Categories { get; }  
        public SalesRepository Sales { get; }  
        public StoreRepository Store { get; }  
        public AddressRepository Addresses { get; }  
        public CustomerAccountRepository CustomersAccount { get; }  
        public CustomerRepository Customers { get; }  
        public AddressBookRepository AddressBook { get; }  
        public ShoppingCartRepository ShoppingCarts { get; }  
        public OrderPendingRepository OrderPendings { get; }  
        public OrderRepository Orders { get; }  
        public HistoryOrderRepository Histories { get; }  
        public CommentRepository Comments { get; }  
        public StatsRepository Stats { get; }  
        //This Method will Start the database Transaction
        public void CreateTransaction();
        //This Method will Commit the database Transaction
        public void Commit();
        //This Method will Rollback the database Transaction
        public void Rollback();
        //This Method will call the SaveChanges method
        Task Save();
    }
}
