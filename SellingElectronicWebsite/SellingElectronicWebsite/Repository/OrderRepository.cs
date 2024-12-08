using AutoMapper;
using Microsoft.EntityFrameworkCore;
using SellingElectronicWebsite.Entities;
using SellingElectronicWebsite.Helper;
using SellingElectronicWebsite.Model;
using SellingElectronicWebsite.ViewModel;
using System.Drawing;
using System.Globalization;
using System.Net.NetworkInformation;

namespace SellingElectronicWebsite.Repository
{
    public class OrderRepository : IOrderRepository
    {
        private SellingElectronicsContext _context;
        private readonly IMapper _mapper;


        public OrderRepository(SellingElectronicsContext context, IMapper mapper)
        {
            _context = context;
            _mapper = mapper;

        }
        /// <summary>
        /// Get all order 
        /// </summary>
        /// <param name="status">value: "pending"/"cancel"/"approve". Default = "pending"</param>
        /// <param name="sortByOrderDate">value: "timeDesc"/"timeAsc". Default = null</param>
        public async Task<List<OrderVM>> GetAll(string status, string sortByOrderDate)
        {
            var listOrder = await _context.Orders
                                                .Include(p => p.Customer)
                                                .Include(p => p.Employee)
                                                .Include(p => p.Store)
                                                .Include(p => p.Store.Address)
                                                .Where(p => p.Status == status)
                                                .ToListAsync();

            if (!string.IsNullOrEmpty(sortByOrderDate))
            {
                switch (sortByOrderDate)
                {
                    case "timeAsc": listOrder = listOrder.OrderBy(p => p.OdertDate).ToList(); break;
                    case "timeDesc": listOrder = listOrder.OrderByDescending(p => p.OdertDate).ToList(); break;
                }
            }

            List<OrderVM> listOrderVM = _mapper.Map<List<OrderVM>>(listOrder);
           
            // add product for list for order
            foreach (OrderVM item in listOrderVM)
            {
                var listProductOrder = await _context.ProductOrders
                                                             .Where(p => p.OrderId == item.OrderId)
                                                             .Include(p => p.Product)
                                                             .Include(p => p.Product.Category)
                                                             .Include(p => p.Color)
                                                             .ToListAsync();
                item.ListProductOrder = _mapper.Map<List<ProductOrderVM>>(listProductOrder);
            }
           
            //add sale
            foreach (var itemOrder in listOrderVM)
            {
                foreach (var itemProduct in itemOrder.ListProductOrder)
                {
                    if (itemOrder.OdertDate != null)
                    {
                        SalesVM sale = _mapper.Map<SalesVM>(await ProductsRepository.checkSaleByIdProduct(itemProduct.Product.ProductId, (DateTime)itemOrder.OdertDate));
                        if (sale != null)
                        {
                            itemProduct.Product.sale = sale;
                        }
                    }
                    
                }

            }
            return listOrderVM;
        }
        /// <summary>
        /// Get all order by page
        /// </summary>
        /// <param name="status">value: "pending"/"cancel"/"approve". Default = "pending"</param>
        /// <param name="sortByOrderDate">value: "timeDesc"/"timeAsc". Default = null</param>
        public async Task<List<OrderVM>> GetAllPaging(string status, string sortByOrderDate, int pageIndex, int pageSize)
        {
            var listOrder = await _context.Orders
                                               .Include(p => p.Customer)
                                               .Include(p => p.Employee)
                                               .Include(p => p.Store)
                                               .Include(p => p.Store.Address)
                                               .Where(p => p.Status == status)
                                               .ToListAsync();

            if (!string.IsNullOrEmpty(sortByOrderDate))
            {
                switch (sortByOrderDate)
                {
                    case "timeAsc": listOrder = listOrder.OrderBy(p => p.OdertDate).ToList(); break;
                    case "timeDesc": listOrder = listOrder.OrderByDescending(p => p.OdertDate).ToList(); break;
                }
            }

            // paging 
            var queryableProduct = listOrder.AsQueryable();
            var listOrderPaging = PaginatedList<Order>.create(queryableProduct, pageIndex, pageSize);
            
            //map to OrderVM
            List<OrderVM> listOrderVM = _mapper.Map<List<OrderVM>>(listOrderPaging);
           
            // add product for list for order
            foreach (OrderVM item in listOrderVM)
            {
                var listProductOrder = await _context.ProductOrders
                                                             .Where(p => p.OrderId == item.OrderId)
                                                             .Include(p => p.Product)
                                                             .Include(p => p.Product.Category)
                                                             .Include(p => p.Color)
                                                             .ToListAsync();
                item.ListProductOrder = _mapper.Map<List<ProductOrderVM>>(listProductOrder);
            }
            
            //add sale
            foreach (var itemOrder in listOrderVM)
            {
                foreach (var itemProduct in itemOrder.ListProductOrder)
                {
                    SalesVM sale = _mapper.Map<SalesVM>(await ProductsRepository.checkSaleByIdProduct(itemProduct.Product.ProductId, (DateTime)itemOrder.OdertDate));
                    if (sale != null)
                    {
                        itemProduct.Product.sale = sale;
                    }
                }

            }
            return listOrderVM;
        }

        /// <summary>
        /// Get all order by id Store paging
        /// </summary>
        /// <param name="status">value: "pending"/"cancel"/"approve". Default = "pending"</param>
        /// <param name="sortByOrderDate">value: "timeDesc"/"timeAsc". Default = null</param>
        public async Task<List<OrderVM>> GetByIdStorePaging(string status, string? sortByOrderDate, int idStore, int pageIndex, int pageSize)
        {
            var listOrder = await _context.Orders
                                                .Include(p => p.Customer)
                                                .Include(p => p.Employee)
                                                .Include(p => p.Store)
                                                .Include(p => p.Store.Address)
                                                .Where(p => p.Status == status && p.StoreId == idStore)
                                                .ToListAsync();

            if (!string.IsNullOrEmpty(sortByOrderDate))
            {
                switch (sortByOrderDate)
                {
                    case "timeAsc": listOrder = listOrder.OrderBy(p => p.OdertDate).ToList(); break;
                    case "timeDesc": listOrder = listOrder.OrderByDescending(p => p.OdertDate).ToList(); break;
                }
            }

            //paging
            var queryableProduct = listOrder.AsQueryable();
            var listOrderPaging = PaginatedList<Order>.create(queryableProduct, pageIndex, pageSize);

            //map to OrderVM
            List<OrderVM> listOrderVM = _mapper.Map<List<OrderVM>>(listOrderPaging);
            
            // add product for list for order
            foreach (OrderVM item in listOrderVM)
            {
                var listProductOrder = await _context.ProductOrders
                                                             .Where(p => p.OrderId == item.OrderId)
                                                             .Include(p => p.Product)
                                                             .Include(p => p.Product.Category)
                                                             .Include(p => p.Color)
                                                             .ToListAsync();
                item.ListProductOrder = _mapper.Map<List<ProductOrderVM>>(listProductOrder);
            }
            
            //add sale
            foreach (var itemOrder in listOrderVM)
            {
                foreach (var itemProduct in itemOrder.ListProductOrder)
                {
                    SalesVM sale = _mapper.Map<SalesVM>(await ProductsRepository.checkSaleByIdProduct(itemProduct.Product.ProductId, (DateTime)itemOrder.OdertDate));
                    if (sale != null)
                    {
                        itemProduct.Product.sale = sale;
                    }
                }

            }
            return listOrderVM;
        }

        /// <summary>
        /// Get all order by id Store 
        /// </summary>
        /// <param name="status">value: "pending"/"cancel"/"approve". Default = "pending"</param>
        /// <param name="sortByOrderDate">value: "timeDesc"/"timeAsc". Default = null</param>
        public async Task<List<OrderVM>> GetByIdStore(string status, string sortByOrderDate, int idStore)
        {
            var listOrder = await _context.Orders
                                                .Include(p => p.Customer)
                                                .Include(p => p.Employee)
                                                .Include(p => p.Store)
                                                .Include(p => p.Store.Address)
                                                .Where(p => p.Status == status && p.StoreId == idStore)
                                                .ToListAsync();

            if (!string.IsNullOrEmpty(sortByOrderDate))
            {
                switch (sortByOrderDate)
                {
                    case "timeAsc": listOrder = listOrder.OrderBy(p => p.OdertDate).ToList(); break;
                    case "timeDesc": listOrder = listOrder.OrderByDescending(p => p.OdertDate).ToList(); break;
                }
            }

            List<OrderVM> listOrderVM = _mapper.Map<List<OrderVM>>(listOrder);
            // add product for list for order
            foreach (OrderVM item in listOrderVM)
            {
                var listProductOrder = await _context.ProductOrders
                                                             .Where(p => p.OrderId == item.OrderId)
                                                             .Include(p => p.Product)
                                                             .Include(p => p.Product.Category)
                                                             .Include(p => p.Color)
                                                             .ToListAsync();
                item.ListProductOrder = _mapper.Map<List<ProductOrderVM>>(listProductOrder);
            }
            //add sale
            foreach (var itemOrder in listOrderVM)
            {
                foreach (var itemProduct in itemOrder.ListProductOrder)
                {
                    SalesVM sale = _mapper.Map<SalesVM>(await ProductsRepository.checkSaleByIdProduct(itemProduct.Product.ProductId, (DateTime)itemOrder.OdertDate));
                    if (sale != null)
                    {
                        itemProduct.Product.sale = sale;
                    }
                }

            }
            return listOrderVM;
        }

        public async Task<OrderVM> GetByIdOrder(int idOrder)
        {
            var order = await _context.Orders
                                               .Include(p => p.Customer)
                                               .Include(p => p.Employee)
                                               .Include(p => p.Store)
                                               .Include(p => p.Store.Address)
                                               .Where(p => p.OrderId == idOrder)
                                               .FirstOrDefaultAsync();

           
            OrderVM OrderVM = _mapper.Map<OrderVM>(order);
            
            // add product for list for order
            var listProductOrder = await _context.ProductOrders
                                                            .Where(p => p.OrderId == OrderVM.OrderId)
                                                            .Include(p => p.Product)
                                                            .Include(p => p.Product.Category)
                                                            .Include(p => p.Color)
                                                            .ToListAsync();
            OrderVM.ListProductOrder = _mapper.Map<List<ProductOrderVM>>(listProductOrder);
            
            //add sale
            foreach (var itemProduct in OrderVM.ListProductOrder)
            {
                SalesVM sale = _mapper.Map<SalesVM>(await ProductsRepository.checkSaleByIdProduct(itemProduct.Product.ProductId, (DateTime)OrderVM.OdertDate));
                if (sale != null)
                {
                    itemProduct.Product.sale = sale;
                }
            }

            return OrderVM;
        }

       

        public async Task<OrderVM> ExportOrder(int idOrder, int employeeId)
        {
            //check idOder exist
            var order = await _context.Orders
                                       .Include(p => p.Customer)
                                               .Include(p => p.Employee)
                                               .Include(p => p.Store)
                                               .Include(p => p.Store.Address)
                                               .Where(p => p.OrderId == idOrder)
                                               .FirstOrDefaultAsync();

            if(order == null)
            {
                throw new Exception("Order not found!");
            }

            //check status of order
            if(order.Status.ToLower() != "pending")
            {
                throw new Exception("Status of order isn't pending!");
            }
            //check emplpoyee exist
            var checkEmployee = await _context.Employees
                                                        .Where(p => p.EmployeeId == employeeId)
                                                        .FirstOrDefaultAsync();
            if(checkEmployee == null) 
            { 
                throw new Exception("Employee not found!");
            }

            // update employee, status, exportDate
            order.EmployeeId = employeeId;
            order.Employee = checkEmployee;
            order.Status = "approve";
            order.DateExport = DateTime.Now;

            //map order to orderVM
            OrderVM orderVM = _mapper.Map<OrderVM>(order);

            // add sale for item in list product order
            var listProductOrder = await _context.ProductOrders
                                                           .Where(p => p.OrderId == order.OrderId)
                                                           .Include(p => p.Product)
                                                           .Include(p => p.Product.Category)
                                                           .Include(p => p.Color)
                                                           .ToListAsync();
            
            foreach (var itemProduct in listProductOrder)
            {
                SalesVM sale = _mapper.Map<SalesVM>(await ProductsRepository.checkSaleByIdProduct(itemProduct.Product.ProductId, (DateTime)orderVM.OdertDate));

                decimal percentSale = 0;
                if (sale != null)
                {
                    percentSale = sale.PercentSale;
                }

                //update until price
                itemProduct.UntilPrice = itemProduct.Product.Price * (100 - percentSale) / 100;

                //map productOrder to productOrderVM
                ProductOrderVM productOrderVM = _mapper.Map<ProductOrderVM>(itemProduct);
                productOrderVM.Product.sale = sale;

                // add productOrderVM to list of orderVM
                if(orderVM.ListProductOrder == null)
                {
                    orderVM.ListProductOrder = new List<ProductOrderVM>();
                }
                orderVM.ListProductOrder.Add(productOrderVM);
            }


            return orderVM;
        }

        public async Task<OrderVM> CancelOrder(int idOrder, int employeeId)
        {
            //check idOder exist
            var order = await _context.Orders
                                       .Include(p => p.Customer)
                                               .Include(p => p.Employee)
                                               .Include(p => p.Store)
                                               .Include(p => p.Store.Address)
                                               .Where(p => p.OrderId == idOrder)
                                               .FirstOrDefaultAsync();

            if (order == null)
            {
                throw new Exception("Order not found!");
            }

            //check status of order
            if (order.Status.ToLower() != "pending")
            {
                throw new Exception("Status of order isn't pending!");
            }
            //check emplpoyee exist
            var checkEmployee = await _context.Employees
                                                        .Where(p => p.EmployeeId == employeeId)
                                                        .FirstOrDefaultAsync();
            if (checkEmployee == null)
            {
                throw new Exception("Employee not found!");
            }

            // update employee, status, exportDate
            order.EmployeeId = employeeId;
            order.Employee = checkEmployee;
            order.Status = "cancel";
            order.DateExport = DateTime.Now;

            

            // return product for store
            var listProductOrder = await _context.ProductOrders
                                                           .Where(p => p.OrderId == order.OrderId)
                                                           .Include(p => p.Product)
                                                           .Include(p => p.Product.Category)
                                                           .Include(p => p.Color)
                                                           .ToListAsync();

            foreach(var itemProduct in listProductOrder)
            {
                var storeItem = await _context.StoresProducts
                                   .Include(p => p.Store)
                                   .Include(p => p.Product)
                                   .Include(p => p.Color)
                                   .Include(p => p.Product.Category)
                                   .Where(p => p.StoreId == order.StoreId 
                                            && p.ProductId == itemProduct.ProductId 
                                            && p.ColorId == itemProduct.ColorId)
                                   .FirstOrDefaultAsync();
                if (storeItem == null)
                {
                    // get store by id
                    Store store = await _context.Stores.Where(p => p.StoreId == order.StoreId).FirstOrDefaultAsync();
                    if (store == null)
                    {
                        throw new Exception("Store don't exist!");

                    }
                    //get color by id
                    Entities.Color color = await _context.Colors.Where(p => p.ColorId == itemProduct.ColorId).FirstOrDefaultAsync();
                    if (color == null)
                    {
                        throw new Exception("Color don't exist!");

                    }
                    //get product by id
                    Product product = await _context.Products
                                                .Include(p => p.Category)
                                                .Where(p => p.ProductId == itemProduct.ProductId).FirstOrDefaultAsync();
                    if (product == null)
                    {
                        throw new Exception("Product don't exist!");

                    }
                    // create new store product item
                    StoresProduct newStoreProduct = new StoresProduct() { ColorId = (int)itemProduct.ColorId,
                                                                           ProductId = (int)itemProduct.ProductId,
                                                                           StoreId = (int)order.StoreId, 
                                                                            Amount = (int)itemProduct.Amount };
                    newStoreProduct.Store = store;
                    newStoreProduct.Color = color;
                    newStoreProduct.Product = product;
                    await _context.StoresProducts.AddAsync(newStoreProduct);
                    var vm = _mapper.Map<StoreProductVM>(newStoreProduct);

                }
                else
                {
                    storeItem.Amount = storeItem.Amount + itemProduct.Amount;
                    _context.Update(storeItem);
                }
            }

            //map order to orderVM
            OrderVM orderVM = _mapper.Map<OrderVM>(order);
            orderVM.ListProductOrder = _mapper.Map<List<ProductOrderVM>>(listProductOrder);
            return orderVM;
        }


        /// <param name="model">CustomerId can be null</param>
        /// <returns>order View Model</returns>
        public async Task<OrderVM> OderOffline(OrderOfflineModel model)
        {
            // check id employee
            var checkEmployee = await _context.Employees
                                                        .Where(p => p.EmployeeId == model.EmployeeId)
                                                        .FirstOrDefaultAsync();
            if (checkEmployee == null)
            {
                throw new Exception("Employee not found!");
            }

            // check id store
            Store store = await _context.Stores
                                            .Include(p => p.Address)
                                            .Where(p => p.StoreId == model.StoreId)
                                            .FirstOrDefaultAsync();
            if (store == null)
            {
                throw new Exception("Store don't exist!");

            }

            // check id customer(if id != null)
            if(model.CustomerId != null)
            {
                var customer = await _context.Customers
                     .Where(p => p.CustomerId == model.CustomerId).FirstOrDefaultAsync();
                if (customer == null)
                {
                    throw new Exception("Customer id: " + model.CustomerId + " isn't exist!");
                }
            }

            Order newOrder = _mapper.Map<Order>(model);

            // add order infor
            newOrder.Status = "approve";
            newOrder.OrderType = "offline";
            newOrder.DateExport = DateTime.Now;
            newOrder.CustomerId = model.CustomerId;

            //add and save change to get id order
            await _context.AddAsync(newOrder);
            await _context.SaveChangesAsync();

            List<ProductOrderVM> productOrderVMs = new List<ProductOrderVM>();
            // check id each product in list
            foreach (ProductOrderModel item in model.ListProductOrder)
            {

                //get item in store 
                var itemProductInStore = await _context.StoresProducts
                                                .Include(p => p.Product)
                                                .Include(p => p.Product.Category)
                                                .Where(p => p.StoreId == model.StoreId
                                                        && p.ProductId == item.ProductId
                                                        && p.ColorId == item.ColorId)
                                                .FirstOrDefaultAsync();
                if (itemProductInStore == null)
                {
                    throw new Exception("This product don't exist in store by id store: " + model.StoreId);
                }
                //check amount in store with amount order
                if (item.Amount > itemProductInStore.Amount)
                {
                    throw new Exception("The product not enough of for order!");
                }
                else // reduce amount of item product in this store
                {
                    itemProductInStore.Amount = itemProductInStore.Amount - item.Amount;
                }

                // get until price by sale
                SalesVM sale = _mapper.Map<SalesVM>(await ProductsRepository.checkSaleByIdProduct(itemProductInStore.Product.ProductId, (DateTime)newOrder.OdertDate));
                decimal percentSale = 0;
                if (sale != null)
                {
                    percentSale = sale.PercentSale;
                }
                var untilPrice = itemProductInStore.Product.Price * (100 - percentSale) / 100;
                //create new prodcut Order
                ProductOrder productOrder = new ProductOrder() { 
                                                                Amount = item.Amount,
                                                                ProductId = item.ProductId, 
                                                                ColorId = item.ColorId,
                                                                OrderId = newOrder.OrderId,
                                                                UntilPrice = untilPrice

                };

                

                // add new product order
                await _context.AddAsync(productOrder);
                // save to get id
                await _context.SaveChangesAsync();
                // update new amount of item product in store
                _context.Update(itemProductInStore);

                // add to list product order view model
                var productOrderVM = _mapper.Map<ProductOrderVM>(productOrder);
                productOrderVM.Product.sale = sale;
                productOrderVMs.Add(productOrderVM);
            }

            //map to View Model
            var orderVM = _mapper.Map<OrderVM>(newOrder);
            orderVM.ListProductOrder = productOrderVMs;
            
            return orderVM;
        }

        public async Task<List<OrderVM>> GetByIdCustomer(int idCustomer, string status)
        {
            var listOrder = await _context.Orders
                                                .Include(p => p.Customer)
                                                .Include(p => p.Employee)
                                                .Include(p => p.Store)
                                                .Include(p => p.Store.Address)
                                                .Where(p => p.Status == status && p.CustomerId == idCustomer)
                                                .ToListAsync();

            

            List<OrderVM> listOrderVM = _mapper.Map<List<OrderVM>>(listOrder);

            // add product for list for order
            foreach (OrderVM item in listOrderVM)
            {
                var listProductOrder = await _context.ProductOrders
                                                             .Where(p => p.OrderId == item.OrderId)
                                                             .Include(p => p.Product)
                                                             .Include(p => p.Product.Category)
                                                             .Include(p => p.Color)
                                                             .ToListAsync();
                item.ListProductOrder = _mapper.Map<List<ProductOrderVM>>(listProductOrder);
            }

            //add sale
            foreach (var itemOrder in listOrderVM)
            {
                foreach (var itemProduct in itemOrder.ListProductOrder)
                {
                    if (itemOrder.OdertDate != null)
                    {
                        SalesVM sale = _mapper.Map<SalesVM>(await ProductsRepository.checkSaleByIdProduct(itemProduct.Product.ProductId, (DateTime)itemOrder.OdertDate));
                        if (sale != null)
                        {
                            itemProduct.Product.sale = sale;
                        }
                    }

                }

            }
            return listOrderVM;
        }
    }
}
