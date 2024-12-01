using Microsoft.EntityFrameworkCore.Storage;
using Microsoft.EntityFrameworkCore;
using SellingElectronicWebsite.Repository;
using SellingElectronicWebsite.Entities;
using AutoMapper;
using SellingElectronicWebsite.UnitOfWork;
using Microsoft.Extensions.Configuration;
namespace SellingElectronicWebsite.UnitOfWork
{
    public class UnitOfWork : IUnitOfWork, IDisposable
    {

        public SellingElectronicsContext Context = null;
        private IDbContextTransaction? _objTran = null;
        private IConfiguration _configuration;

        public ProductsRepository Products { get; private set; }
        public ColorsRepository Colors { get; private set; }
        public CategoryRepository Categories { get; private set; }
        public SalesRepository Sales { get; private set; }
        public StoreRepository Store { get; private set; }
        public AddressRepository Addresses { get; private set; }
        public CustomerAccountRepository CustomersAccount { get; private set; }
        public CustomerRepository Customers { get; private set; }
        public AddressBookRepository AddressBook { get; private set; }
        public ShoppingCartRepository ShoppingCarts { get; private set; }
        public OrderPendingRepository OrderPendings { get; private set; }
        public OrderRepository Orders { get; private set; }
        public HistoryOrderRepository Histories { get; private set; }
        public CommentRepository Comments { get; private set; }
        public StatsRepository Stats { get; private set; }

        public UnitOfWork(SellingElectronicsContext _Context, IMapper mapper, IConfiguration configuration)
        {
            Context = _Context;
            _configuration = configuration;
            Products = new ProductsRepository(Context, mapper);
            Colors = new ColorsRepository(Context, mapper);
            Categories = new CategoryRepository(Context, mapper);
            Sales = new SalesRepository(Context, mapper);
            Store = new StoreRepository(Context, mapper);
            Addresses = new AddressRepository(Context, mapper);
            CustomersAccount = new CustomerAccountRepository(Context, mapper, configuration);
            Customers = new CustomerRepository(Context, mapper);
            AddressBook = new AddressBookRepository(Context, mapper);
            ShoppingCarts = new ShoppingCartRepository(Context, mapper);
            OrderPendings = new OrderPendingRepository(Context, mapper);
            Orders = new OrderRepository(Context, mapper);
            Histories = new HistoryOrderRepository(Context, mapper);
            Comments = new CommentRepository(Context, mapper);
            Stats = new StatsRepository(Context, mapper);
        }

        public void CreateTransaction()
        {
            _objTran = Context.Database.BeginTransaction();
        }
        public void Commit()
        {
            _objTran?.Commit();
        }
        public void Rollback()
        {
            _objTran?.Rollback();
            _objTran?.Dispose();
        }
        public async Task Save()
        {
            try
            {
                await Context.SaveChangesAsync();
            }
            catch (DbUpdateException ex)
            {
                throw new Exception(ex.Message, ex);
            }
        }
        public void Dispose()
        {
            Context.Dispose();
        }


    }
}
