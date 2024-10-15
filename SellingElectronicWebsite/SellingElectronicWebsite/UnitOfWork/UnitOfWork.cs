using Microsoft.EntityFrameworkCore.Storage;
using Microsoft.EntityFrameworkCore;
using SellingElectronicWebsite.Repository;
using SellingElectronicWebsite.Entities;
using AutoMapper;
using SellingElectronicWebsite.UnitOfWork;
namespace SellingElectronicWebsite.UnitOfWork
{
    public class UnitOfWork : IUnitOfWork, IDisposable
    {

        public SellingElectronicsContext Context = null;
        private IDbContextTransaction? _objTran = null;

        public ProductsRepository Products { get; private set; }
        public ColorsRepository Colors { get; private set; }
        public CategoryRepository Categories { get; private set; }

        public UnitOfWork(SellingElectronicsContext _Context, IMapper mapper)
        {
            Context = _Context;
            Products = new ProductsRepository(Context, mapper);
            Colors = new ColorsRepository(Context, mapper);
            Categories = new CategoryRepository(Context, mapper);
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
