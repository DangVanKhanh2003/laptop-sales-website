using AutoMapper;
using Microsoft.EntityFrameworkCore;
using SellingElectronicWebsite.Entities;
using SellingElectronicWebsite.Model;
using SellingElectronicWebsite.ViewModel;

namespace SellingElectronicWebsite.Repository
{
    public class ShoppingCartRepository : IShoppingCartRepository
    {
        private SellingElectronicsContext _context;
        private readonly IMapper _mapper;


        public ShoppingCartRepository(SellingElectronicsContext context, IMapper mapper)
        {
            _context = context;
            _mapper = mapper;

        }
        public async Task<SalesVM> checkSaleByIdProduct(int idProduct)
        {
            var sale = await _context.Sales.Where(s => s.ProductId == idProduct && DateTime.Now <= s.EndAt && DateTime.Now >= s.StartAt).FirstOrDefaultAsync();
            return _mapper.Map<SalesVM>(sale);
        }
        /// <summary>
        /// if exist element(in shopping cart) same idCustomer, idProduct, idColor with this item => addition amount to amount ofelement in this shopping cart.
        /// </summary>
        public async Task<bool> Add(ShoppingCartItemModel model)
        {
            if(model.Amount <= 0)
            {
                throw new Exception("Amount invalid");
            }
            var checkCustomerExist = await _context.Customers.Where(p => p.CustomerId == model.CustomerId).FirstOrDefaultAsync();
            if (checkCustomerExist == null)
            {
                throw new Exception("Customer don't exist by id customer: " + model.CustomerId + " !");
            }
            var checkProductExist = await _context.Products.Where(p => p.ProductId == model.ProductId).FirstOrDefaultAsync();
            if (checkProductExist == null)
            {
                throw new Exception("Product don't exist by id product: " + model.ProductId + " !");
            }
            var Colors = await _context.ImageProducts.Include(p => p.Color)
                                                         .Where(p => p.ProductId == model.ProductId && p.ColorId == model.ColorId)
                                                         .Select(p => new ColorVM(p.ColorId, p.Color.ColorName)).Distinct().FirstOrDefaultAsync();
            if (Colors == null)
            {
                throw new Exception("Product haven't color by id color: " + model.ColorId + " !");
            }
            var item = await _context.ShoppingCarts.Where(p => p.CustomerId == model.CustomerId && p.ProductId == model.ProductId && p.ColorId == model.ColorId).FirstOrDefaultAsync();
            if(item != null)
            {
                item.Amount = model.Amount + item.Amount;
                _context.ShoppingCarts.Update(item);
            }
            else
            {
                var newShopingCart = _mapper.Map<ShoppingCart>(model);
                await _context.AddAsync(newShopingCart);
            }

            return true;
        }

        public async Task<bool> Delete(int idShoppingCartItem)
        {
            var item = await _context.ShoppingCarts.Where(p => p.ShoppingCartId == idShoppingCartItem).FirstOrDefaultAsync();
            if (item == null)
            {
                throw new Exception(" Don't exist item!");
            }
            _context.Remove(item);
            return true;
        }

        public async Task<List<ShoppingCartItemVM>> GetByIdCustomer(int idCustomer)
        {
            var items = await _context.ShoppingCarts
                                .Include(p => p.Product)
                                .Include(p => p.Color)
                                .Where(p => p.CustomerId == idCustomer)
                                .Select(p => new ShoppingCartItemVM(
                                                            p.ShoppingCartId,
                                                            p.ProductId,
                                                            p.CustomerId,
                                                            p.Product.ProductName,
                                                            p.Amount,
                                                            p.Color.ColorName,
                                                            p.Product.Brand,
                                                            p.Product.Series,
                                                            p.Product.Price,
                                                            p.Product.Category.CategoryName,
                                                            p.Product.MainImg
                                ))
                                .ToListAsync();
            foreach (var item in items)
            {
                SalesVM sale = _mapper.Map<SalesVM>(await ProductsRepository.checkSaleByIdProduct(item.ProductId, DateTime.Now));
                if (sale != null)
                {
                    item.sale = sale;
                }
            }

            return items;
        }

       /// <summary>
       /// update amount for item in shoppingCart by idShoppingCart
       /// </summary>
        public async Task<bool> UpdateAmount(int amount, int idShoppingCartItem)
        {
            
            var item = await _context.ShoppingCarts.Where(p => p.ShoppingCartId == idShoppingCartItem).FirstOrDefaultAsync();
            if (item == null)
            {
                throw new Exception(" Don't exist item!");
            }

            if(amount <= 0)
            {
                throw new Exception("Amount invalid");
            }
            item.Amount = amount;
            _context.ShoppingCarts.Update(item);
            return true;
        }

        public async Task<bool> DeleteAllByIdCustomer(int idCustomer)
        {
            var items = await _context.ShoppingCarts.Where(p => p.CustomerId == idCustomer).ToListAsync();
            if (items.Count == 0)
            {
                throw new Exception("Don't exist item!");
            }

           foreach(var item in items)
            {
                _context.ShoppingCarts.Remove(item);
            }
            return true;
        }
    }
}
