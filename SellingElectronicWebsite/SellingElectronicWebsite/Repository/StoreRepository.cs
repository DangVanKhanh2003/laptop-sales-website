using AutoMapper;
using Microsoft.AspNetCore.Http.HttpResults;
using Microsoft.EntityFrameworkCore;
using SellingElectronicWebsite.Entities;
using SellingElectronicWebsite.Model;
using SellingElectronicWebsite.ViewModel;
using System.Drawing;

namespace SellingElectronicWebsite.Repository
{
    public class StoreRepository : IStoreRepository
    {
        private SellingElectronicsContext _context;
        private readonly IMapper _mapper;


        public StoreRepository(SellingElectronicsContext context, IMapper mapper)
        {
            _context = context;
            _mapper = mapper;

        }

        public async Task<SalesVM> checkSaleByIdProduct(int idProduct)
        {
            var sale = await _context.Sales.Where(s => s.ProductId == idProduct && DateTime.Now <= s.EndAt && DateTime.Now >= s.StartAt).FirstOrDefaultAsync();
            return _mapper.Map<SalesVM>(sale);
        }

        public async Task<bool> AddStore(Store model)
        {
           
            await _context.Stores.AddAsync(model);
            return true;
        }

        public async Task<int> DeleteStore(int idStore)
        {
            var item = await _context.Stores.Where(s => s.StoreId == idStore).FirstOrDefaultAsync();
            if (item != null)
            {
                var idItem = item.StoreId;

                _context.Stores.Remove(item);
                return idItem;
            }
            return -1;
        }
        public async Task<AddressVM> getAddressByStoreId(int storeId)
        {
            var item = await _context.Stores.Where(s => s.StoreId == storeId).FirstOrDefaultAsync();
            Address address = await _context.Addresses.Where(a => a.AddressId == item.AddressId).FirstOrDefaultAsync();

            return _mapper.Map< AddressVM>(address);
        }
        public async Task<List<StoreVM>> GetAllStore()
        {
            var Stores = await _context.Stores.ToListAsync();
            var StoresVM = _mapper.Map<List<StoreVM>>(Stores);
            foreach (var item in StoresVM)
            {
                AddressVM address = await getAddressByStoreId(item.StoreId);
                if (address != null)
                {
                    item.Address = address;
                }
            }
            return StoresVM;
        }

        public async Task<StoreVM> GetStoreById(int idStore)
        {
            var item = await _context.Stores.Where(s => s.StoreId == idStore).FirstOrDefaultAsync();
            var StoreVM = _mapper.Map<StoreVM>(item);
            AddressVM address = await getAddressByStoreId(item.StoreId);
            if (address != null)
            {
                StoreVM.Address = address;
            }
            return StoreVM;
        }

        public async Task<StoreVM> GetStoreByName(string nameStore)
        {
            var item = await _context.Stores.Where(c => c.StoreName.Equals(nameStore)).FirstOrDefaultAsync();
            var itemVM = _mapper.Map<StoreVM>(item);
            return itemVM;
        }

        public async Task<bool> UpdateStore(StoreModel model, int idStore)
        {
            var item = await _context.Stores.Where(c => c.StoreId.Equals(idStore)).FirstOrDefaultAsync();
            if (item == null)
            {
                return false;
            }
            var itemAddress = _mapper.Map<Address>(model.Address);
            var address = await _context.Addresses.Where(c => c.AddressId.Equals(item.AddressId)).FirstOrDefaultAsync();
            await _context.Addresses.AddAsync(itemAddress);
            _context.Update(address);
            item.StoreName = model.StoreName;
            _context.Update(item);
            return true;
        }

        public async Task<List<StoreProductVM>> GetAllProductByIdStore(int idStore)
        {
            var storeProducts = await _context.StoresProducts
                                                .Include(p => p.Product)
                                                .Where(p => p.StoreId == idStore)
                                                .Select(p => new StoreProductVM(
                                                                                  _mapper.Map<StoreVM>(p.Store),
                                                                                  _mapper.Map <ProductVM>( p.Product),
                                                                                  p.Amount,
                                                                                  _mapper.Map<ColorVM>(p.Color)
                                                    ))
                                                .ToListAsync();

            foreach (var item in storeProducts)
            {
                SalesVM sale = await checkSaleByIdProduct(item.Product.ProductId);
                if (sale != null)
                {
                    item.Product.sale = sale;
                }
            }

            return storeProducts;
        }

        public async Task<StoreProductVM> GetProductByIdStore(int idStore, int idProduct)
        {
            var storeProduct = await _context.StoresProducts
                                                 .Include(p => p.Product)
                                                 .Where(p => p.StoreId == idStore && p.ProductId == idProduct)
                                                 .Select(p => new StoreProductVM(
                                                                                   _mapper.Map<StoreVM>(p.Store),
                                                                                   _mapper.Map<ProductVM>(p.Product),
                                                                                   p.Amount,
                                                                                   _mapper.Map<ColorVM>(p.Color)
                                                     ))
                                                 .FirstOrDefaultAsync();

                SalesVM sale = await checkSaleByIdProduct(storeProduct.Product.ProductId);
                if (sale != null)
                {
                storeProduct.Product.sale = sale;
                }
            return storeProduct;
        }

        public async Task<List<StoreProductVM>> GetStoreExistProduct(int idProduct)
        {
            var storeVMs = await _context.StoresProducts
                                                 .Where(p =>  p.ProductId == idProduct)
                                                 .Select(p => new StoreProductVM(
                                                                                   _mapper.Map<StoreVM>(p.Store),
                                                                                   _mapper.Map<ProductVM>(p.Product),
                                                                                   p.Amount,
                                                                                   _mapper.Map<ColorVM>( p.Color)
                                                     ))
                                                 .ToListAsync();
            return storeVMs;
        }

        public async Task<StoreProductVM> AddStoreProduct(int idProduct, int idStore, int amountAdd, int idColor)
        {
            if(amountAdd <= 0)
            {
                throw new Exception("Amount invalid!");
            }
            var item = await _context.StoresProducts
                                    .Include(p => p.Store)
                                    .Include(p => p.Product)
                                    .Include(p => p.Color)
                                    .Include(p => p.Product.Category)
                                    .Where(p => p.StoreId == idStore && p.ProductId == idProduct && p.ColorId == idColor).FirstOrDefaultAsync();
            if(item == null)
            {
                // get store by id
                Store   store = await _context.Stores.Where(p => p.StoreId == idStore).FirstOrDefaultAsync();
                if (store == null)
                {
                    throw new Exception("Store don't exist!");

                }
                //get color by id
                Entities.Color color = await _context.Colors.Where(p => p.ColorId == idColor).FirstOrDefaultAsync();
                if (color == null)
                {
                    throw new Exception("Color don't exist!");

                }
                //get product by id
                Product product = await _context.Products
                                            .Include(p => p.Category)
                                            .Where(p => p.ProductId == idProduct).FirstOrDefaultAsync();
                if (product == null)
                {
                    throw new Exception("Product don't exist!");

                }
                // create new store product item
                StoresProduct newStoreProduct = new StoresProduct() { ColorId = idColor , ProductId = idProduct, StoreId = idStore, Amount = amountAdd};
                newStoreProduct.Store = store;
                newStoreProduct.Color = color;
                newStoreProduct.Product = product;
                await _context.StoresProducts.AddAsync(newStoreProduct);
                var vm = _mapper.Map<StoreProductVM>(newStoreProduct);
                return vm;

            }
            else
            {
                item.Amount = item.Amount + amountAdd;
                _context.Update(item);
                var vm =  _mapper.Map<StoreProductVM>(item);
                return vm;
            }

        }

        public async Task<StoreProductVM> ReduceStoreProduct(int idProduct, int idStore, int amountReduce, int idColor)
        {
            if (amountReduce <= 0)
            {
                throw new Exception("Amount invalid!");
            }
            var item = await _context.StoresProducts
                                                .Include(p => p.Store)
                                                .Include(p => p.Product)
                                                .Include(p => p.Color)
                                                .Include(p => p.Product.Category)
                                                .Where(p => p.StoreId == idStore && p.ProductId == idProduct && p.ColorId == idColor)
                                                .FirstOrDefaultAsync(); 
            if (item == null)
            {
                throw new Exception("Not found item!");

            }
            else
            {
                if(item.Amount < amountReduce)
                {
                    throw new Exception("Amount reduce exceeds store product quantity!");

                }
                item.Amount = item.Amount - amountReduce;
                _context.Update(item);
                return _mapper.Map<StoreProductVM>(item);
            }
        }

        public async Task<StoreProductVM> UpdateAmountStoreProduct(int idProduct, int idStore, int amount, int idColor)
        {
            if (amount <= 0)
            {
                throw new Exception("Amount invalid!");
            }
            var item = await _context.StoresProducts
                                                .Include(p => p.Store)
                                                .Include(p => p.Product)
                                                .Include(p => p.Color)
                                                .Include(p => p.Product.Category)
                                                .Where(p => p.StoreId == idStore && p.ProductId == idProduct && p.ColorId == idColor)
                                                .FirstOrDefaultAsync();
            if (item == null)
            {
                throw new Exception("Not found item!");

            }
            else
            {
                
                item.Amount = amount;
                _context.Update(item);
                return _mapper.Map<StoreProductVM>(item);
            }
        }
    }
}

