using AutoMapper;
using Microsoft.EntityFrameworkCore;
using SellingElectronicWebsite.Entities;
using SellingElectronicWebsite.Helper;
using SellingElectronicWebsite.Model;
using SellingElectronicWebsite.ViewModel;
using System.Globalization;
using System.Linq;
using System.Net.NetworkInformation;

namespace SellingElectronicWebsite.Repository
{
    public class OrderPendingRepository : IOrderPendingRepository
    {
        private SellingElectronicsContext _context;
        private readonly IMapper _mapper;


        public OrderPendingRepository(SellingElectronicsContext context, IMapper mapper)
        {
            _context = context;
            _mapper = mapper;

        }
        
        /// <summary>
        /// after add, The system will automatically set pending for status and auto set time for order. 
        /// </summary>
        public async Task<bool> Add(OrderPendingModel model)
        {
            if (model.ListProductOrederPending.Count() == 0)
            {
                throw new Exception("Cannot add order because the order don't have item");
            }
            OrderPending newOrderPending = new OrderPending()
            {
                CustomerId = model.CustomerId,
                OdertDate = DateTime.Now,
                EmployeeId = null,
                Status = "pending"
            };
            await _context.AddAsync(newOrderPending);
            //save to get id orderPending
            await _context.SaveChangesAsync();
            // add item in list product order pending into ProductOrderPending table
            foreach (var item in model.ListProductOrederPending)
            {
                if (item.Amount <= 0)
                {
                    throw new Exception("The order contains products with invalid quantity.!");
                }
                var product = _mapper.Map<ProductOrderPending>(item);
                //set id for product item
                product.OrderPendingId = newOrderPending.OrderPendingId;
                await _context.AddAsync(product);
            }
            return true;
        }
        /// <summary>
        /// actor: user => user can cancel order 
        /// </summary>
        public async Task<bool> Cancel(int id)
        {
            var item = await _context.OrderPendings.Where(p => p.OrderPendingId == id).FirstOrDefaultAsync();
            if (item == null)
            {
                throw new Exception("Don't exist order by id: " + id);
            }
            if (item.Status.ToString().ToLower() != "pending")
            {
                throw new Exception("Can not cancel order. Because your order has been processed. Please contact employee!");
            }
            item.Status = "cancel";
            _context.OrderPendings.Update(item);
            return true;
        }
        /// <summary>
        /// get all order pending by status and sort by time
        /// </summary>
        /// <param name="status">cancel/pending/approve</param>
        /// <param name="sortBy">timeAsc/timeDesc/null</param>
        public async Task<List<OrderPendingVM>> GetAll(string status, string sortBy)
        {
            var listOrderPending = await _context.OrderPendings
                                                        .Include(p => p.Customer)
                                                        .Include(p => p.Employee)
                                                        .Where(p => p.Status == status)
                                                        .Select(p => new OrderPendingVM(
                                                                                        p.OrderPendingId,
                                                                                        p.Customer.FullName,
                                                                                        p.Customer.CustomerId,
                                                                                        p.Employee.EmployeeId,
                                                                                        p.Employee.FullName,
                                                                                        p.OdertDate,
                                                                                        p.Status
                                                                                        ))
                                                        .ToListAsync();

            if (!string.IsNullOrEmpty(sortBy))
            {
                switch (sortBy)
                {
                    case "timeAsc": listOrderPending = listOrderPending.OrderBy(p => p.OdertDate).ToList(); break;
                    case "timeDesc": listOrderPending = listOrderPending.OrderByDescending(p => p.OdertDate).ToList(); break;
                }
            }
            // add list for order pending item
            foreach (var item in listOrderPending)
            {
                var listProductOrderPendingVM = await _context.ProductOrderPendings
                                                             .Where(p => p.OrderPendingId == item.OrderPendingId)
                                                             .Include(p => p.Product)
                                                             .Select(p => new ProductOrderPendingVM(
                                                                                                p.ProductOrderPendingId,
                                                                                                p.Product.ProductId,
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
                item.ListProductOrederPending = listProductOrderPendingVM;
            }
            //add sale
            foreach (var itemOrder in listOrderPending)
            {
                foreach (var itemProduct in itemOrder.ListProductOrederPending)
                {
                    SalesVM sale = _mapper.Map<SalesVM>(await ProductsRepository.checkSaleByIdProduct(itemProduct.ProductId, (DateTime)itemOrder.OdertDate));
                    if (sale != null)
                    {
                        itemProduct.sale = sale;
                    }
                }

            }
            return listOrderPending;
        }

        public async Task<OrderPendingVM> GetById(int id)
        {
            var OrderPending = await _context.OrderPendings
                                                        .Include(p => p.Customer)
                                                        .Include(p => p.Employee)
                                                        .Where(p => p.OrderPendingId == id)
                                                        .Select(p => new OrderPendingVM(p.OrderPendingId,
                                                                                        p.Customer.FullName,
                                                                                        p.Customer.CustomerId,
                                                                                        p.Employee.EmployeeId,
                                                                                        p.Employee.FullName,
                                                                                        p.OdertDate,
                                                                                        p.Status
                                                                                        ))
                                                        .FirstOrDefaultAsync();
            if (OrderPending == null)
            {
                throw new Exception("Don't exist item by id: " + id);
            }
            // add list for item order pending
            var listProductOrderPendingVM = await _context.ProductOrderPendings
                                                             .Where(p => p.OrderPendingId == OrderPending.OrderPendingId)
                                                             .Include(p => p.Product)
                                                             .Select(p => new ProductOrderPendingVM(
                                                                                                p.ProductOrderPendingId,
                                                                                                p.Product.ProductId,
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
            // add sale for product
            foreach (var itemProduct in listProductOrderPendingVM)
            {
                SalesVM sale = _mapper.Map<SalesVM>(await ProductsRepository.checkSaleByIdProduct(itemProduct.ProductId, (DateTime)OrderPending.OdertDate));
                if (sale != null)
                {
                    itemProduct.sale = sale;
                }
            }
            OrderPending.ListProductOrederPending = listProductOrderPendingVM;
            return OrderPending;
        }

        /// <param name="status">cancel/pending/approve</param>
        /// <param name="sortBy">timeAsc/timeDesc/null</param>
        public async Task<List<OrderPendingVM>> GetByPage(string status, int pageIndex, int pageSize, string sortBy)
        {
            var listOrderPending = await _context.OrderPendings
                                                        .Include(p => p.Customer)
                                                        .Include(p => p.Employee)
                                                        .Where(p => p.Status == status)
                                                        .Select(p => new OrderPendingVM(p.OrderPendingId,
                                                                                        p.Customer.FullName,
                                                                                        p.Customer.CustomerId,
                                                                                        p.Employee.EmployeeId,
                                                                                        p.Employee.FullName,
                                                                                        p.OdertDate,
                                                                                        p.Status
                                                                                        ))
                                                        .ToListAsync();

            if (!string.IsNullOrEmpty(sortBy))
            {
                switch (sortBy)
                {
                    case "timeAsc": listOrderPending = listOrderPending.OrderBy(p => p.OdertDate).ToList(); break;
                    case "timeDesc": listOrderPending = (List<OrderPendingVM>)listOrderPending.OrderByDescending(p => p.OdertDate); break;
                }
            }
            // add list product for order pending item
            foreach (var item in listOrderPending)
            {
                var listProductOrderPendingVM = await _context.ProductOrderPendings
                                                             .Where(p => p.OrderPendingId == item.OrderPendingId)
                                                             .Include(p => p.Product)
                                                             .Select(p => new ProductOrderPendingVM(
                                                                                                 p.ProductOrderPendingId,
                                                                                                p.Product.ProductId,
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
                item.ListProductOrederPending = listProductOrderPendingVM;
            }
            //add sale for product
            foreach (var itemOrder in listOrderPending)
            {
                foreach (var itemProduct in itemOrder.ListProductOrederPending)
                {
                    SalesVM sale = _mapper.Map<SalesVM>(await ProductsRepository.checkSaleByIdProduct(itemProduct.ProductId, (DateTime)itemOrder.OdertDate));
                    if (sale != null)
                    {
                        itemProduct.sale = sale;
                    }
                }

            }
            var queryableProduct = listOrderPending.AsQueryable();
            var listPaging = PaginatedList<OrderPendingVM>.create(queryableProduct, pageIndex, pageSize);
            return listPaging;
        }
        /// <summary>
        /// actor: employee=> employee can change status: cancel, approve. Employee cannot change status if status isn't pending.
        /// if status is "approve" and input valid => amount of store will reduce by amount order.
        /// </summary>
        public async Task<bool> UpdateStatus(string status, int idOrderPending, int idEmployee, int idStore)
        {

            var item = await _context.OrderPendings.Where(p => p.OrderPendingId == idOrderPending).FirstOrDefaultAsync();
            // check item exist
            if (item == null)
            {
                throw new Exception("Don't exist order by id: " + idOrderPending);
            }
            //check Is status "pending". If item.status isn't pending => throw exception
            if (item.Status.ToString().ToLower() != "pending")
            {
                throw new Exception("Can not change status. Because the order status isn't pendding.");
            }
            var checkEmoloyeeExist = await _context.Employees.Where(p => p.EmployeeId == idEmployee).FirstOrDefaultAsync();
            if (checkEmoloyeeExist == null)
            {
                throw new Exception($"Employe id not found");
            }
            // status is "approve"
            if(status == "approve")
            {
                var checkStore = await _context.Stores.Where(p => p.StoreId == idStore).FirstOrDefaultAsync();
                if(checkStore == null)
                {
                    throw new Exception("Can't change status to \"approve\". Because idStore don't exist!");
                }

                else //check amount product in the store
                {
                    
                    var listOrderPending = await _context.ProductOrderPendings.Where(p => p.OrderPendingId == idOrderPending).ToListAsync();
                    //check amount each product items
                    foreach(var itemProduct in listOrderPending)
                    {
                        //get item in store 
                        var itemProductInStore = await _context.StoresProducts.
                                                        Where(p => p.StoreId == idStore 
                                                                && p.ProductId == itemProduct.ProductId 
                                                                && p.ColorId == itemProduct.ColorId)
                                                        .FirstOrDefaultAsync();
                        if(itemProductInStore == null)
                        {
                            throw new Exception("This product don't exist in store by id store: " + idStore);
                        }    
                        //check amount in store with amount order
                        if (itemProduct.Amount > itemProductInStore.Amount)
                        {
                            throw new Exception("The product not enough of for order!");
                        }
                        else // reduce amount of item product in this store
                        {
                            itemProductInStore.Amount = itemProductInStore.Amount - itemProduct.Amount;
                        }    
                        _context.Update(itemProductInStore);
                    }    

                   //create new order item by infor order pending 
                   Order newOrder = new Order() { 
                                                  CustomerId = item.CustomerId, 
                                                  OdertDate = item.OdertDate, 
                                                  StoreId = idStore, 
                                                  Status = "Pending", 
                                                  OrderType = "online",
                                                  OrderPendingId = item.OrderPendingId,
                   };
                    await _context.AddAsync(newOrder);
                    await _context.SaveChangesAsync();

                    //create order product item for order item by listOrderPending
                    foreach (var itemProduct in listOrderPending)
                    {
                        ProductOrder newProductOrder = new ProductOrder()
                        {
                            OrderId = newOrder.OrderId,
                            ProductId = itemProduct.ProductId,
                            Amount = itemProduct.Amount,
                            ColorId = itemProduct.ColorId
                        };
                        await _context.AddAsync(newProductOrder);
                    }

                }
            }    
            //add infor for order pending item
            item.EmployeeId = idEmployee;
            item.Status = status;
            _context.OrderPendings.Update(item);
            return true;
        }

        public async Task<List<OrderPendingVM>> GetByIdCustomer(int idCustomer, string status)
        {
            var listOrderPending = await _context.OrderPendings
                                                       .Include(p => p.Customer)
                                                       .Include(p => p.Employee)
                                                       .Where(p => p.Status == status && p.CustomerId == idCustomer)
                                                       .Select(p => new OrderPendingVM(
                                                                                       p.OrderPendingId,
                                                                                       p.Customer.FullName,
                                                                                       p.Customer.CustomerId,
                                                                                       p.Employee.EmployeeId,
                                                                                       p.Employee.FullName,
                                                                                       p.OdertDate,
                                                                                       p.Status
                                                                                       ))
            .ToListAsync();

            // add list for order pending item
            foreach (var item in listOrderPending)
            {
                var listProductOrderPendingVM = await _context.ProductOrderPendings
                                                             .Where(p => p.OrderPendingId == item.OrderPendingId)
                                                             .Include(p => p.Product)
                                                             .Select(p => new ProductOrderPendingVM(
                                                                                                p.ProductOrderPendingId,
                                                                                                p.Product.ProductId,
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
                item.ListProductOrederPending = listProductOrderPendingVM;
            }
            //add sale
            foreach (var itemOrder in listOrderPending)
            {
                foreach (var itemProduct in itemOrder.ListProductOrederPending)
                {
                    SalesVM sale = _mapper.Map<SalesVM>(await ProductsRepository.checkSaleByIdProduct(itemProduct.ProductId, (DateTime)itemOrder.OdertDate));
                    if (sale != null)
                    {
                        itemProduct.sale = sale;
                    }
                }

            }
            return listOrderPending;
        }
    }
}
