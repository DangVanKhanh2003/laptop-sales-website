using AutoMapper;
using Microsoft.EntityFrameworkCore;
using SellingElectronicWebsite.Entities;
using SellingElectronicWebsite.Helper;
using SellingElectronicWebsite.ViewModel;
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
                    SalesVM sale = _mapper.Map<SalesVM>(await ProductsRepository.checkSaleByIdProduct(itemProduct.Product.ProductId));
                    if (sale != null)
                    {
                        itemProduct.Product.sale = sale;
                    }
                }

            }
            return listOrderVM;
        }

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
                    SalesVM sale = _mapper.Map<SalesVM>(await ProductsRepository.checkSaleByIdProduct(itemProduct.Product.ProductId));
                    if (sale != null)
                    {
                        itemProduct.Product.sale = sale;
                    }
                }

            }
            return listOrderVM;
        }

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
                    SalesVM sale = _mapper.Map<SalesVM>(await ProductsRepository.checkSaleByIdProduct(itemProduct.Product.ProductId));
                    if (sale != null)
                    {
                        itemProduct.Product.sale = sale;
                    }
                }

            }
            return listOrderVM;
        }

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
                    SalesVM sale = _mapper.Map<SalesVM>(await ProductsRepository.checkSaleByIdProduct(itemProduct.Product.ProductId));
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

           
            OrderVM listOrderVM = _mapper.Map<OrderVM>(order);
            
            // add product for list for order
            var listProductOrder = await _context.ProductOrders
                                                            .Where(p => p.OrderId == listOrderVM.OrderId)
                                                            .Include(p => p.Product)
                                                            .Include(p => p.Product.Category)
                                                            .Include(p => p.Color)
                                                            .ToListAsync();
            listOrderVM.ListProductOrder = _mapper.Map<List<ProductOrderVM>>(listProductOrder);
            
            //add sale
            foreach (var itemProduct in listOrderVM.ListProductOrder)
            {
                SalesVM sale = _mapper.Map<SalesVM>(await ProductsRepository.checkSaleByIdProduct(itemProduct.Product.ProductId));
                if (sale != null)
                {
                    itemProduct.Product.sale = sale;
                }
            }

            return listOrderVM;
        }

        public Task<OrderVM> OderOffline()
        {
            throw new NotImplementedException();
        }

        public async Task<OrderVM> ExportOder(int idOrder, int employeeId)
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
                SalesVM sale = _mapper.Map<SalesVM>(await ProductsRepository.checkSaleByIdProduct(itemProduct.Product.ProductId));

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

        public Task<OrderVM> CancelOder(int idOrder, int employeeId)
        {
            throw new NotImplementedException();
        }
    }
}
