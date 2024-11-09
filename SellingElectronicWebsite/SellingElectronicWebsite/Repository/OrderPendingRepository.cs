using AutoMapper;
using Microsoft.EntityFrameworkCore;
using SellingElectronicWebsite.Entities;
using SellingElectronicWebsite.Helper;
using SellingElectronicWebsite.Model;
using SellingElectronicWebsite.ViewModel;
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
        public async Task<SalesVM> checkSaleByIdProduct(int idProduct)
        {
            var sale = await _context.Sales.Where(s => s.ProductId == idProduct && DateTime.Now <= s.EndAt && DateTime.Now >= s.StartAt).FirstOrDefaultAsync();
            return _mapper.Map<SalesVM>(sale);
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
                    case "timeDesc": listOrderPending = (List<OrderPendingVM>)listOrderPending.OrderByDescending(p => p.OdertDate); break;
                }
            }
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
            foreach (var itemOrder in listOrderPending)
            {
                foreach( var itemProduct in itemOrder.ListProductOrederPending)
                {
                    SalesVM sale = await checkSaleByIdProduct(itemProduct.ProductId);
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
            var listOrderPending = await _context.OrderPendings
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
            if (listOrderPending == null)
            {
                throw new Exception("Don't exist item by id: " + id);
            }
            var listProductOrderPendingVM = await _context.ProductOrderPendings
                                                             .Where(p => p.OrderPendingId == listOrderPending.OrderPendingId)
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
            foreach (var itemProduct in listProductOrderPendingVM)
            {
                SalesVM sale = await checkSaleByIdProduct(itemProduct.ProductId);
                if (sale != null)
                {
                    itemProduct.sale = sale;
                }
            }
            listOrderPending.ListProductOrederPending = listProductOrderPendingVM;
            return listOrderPending;
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
            if (sortBy == "timeAsc")
            {
                listOrderPending.OrderBy(p => p.OdertDate);
            }
            else if (sortBy == "timeDesc")
            {
                listOrderPending.OrderByDescending(p => p.OdertDate);

            }
            if (!string.IsNullOrEmpty(sortBy))
            {
                switch (sortBy)
                {
                    case "timeAsc": listOrderPending = listOrderPending.OrderBy(p => p.OdertDate).ToList(); break;
                    case "timeDesc": listOrderPending = (List<OrderPendingVM>)listOrderPending.OrderByDescending(p => p.OdertDate); break;
                }
            }
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
            foreach (var itemOrder in listOrderPending)
            {
                foreach (var itemProduct in itemOrder.ListProductOrederPending)
                {
                    SalesVM sale = await checkSaleByIdProduct(itemProduct.ProductId);
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
        /// </summary>
        public async Task<bool> UpdateStatus(string status, int idOrderPending, int idEmployee)
        {
            var item = await _context.OrderPendings.Where(p => p.OrderPendingId == idOrderPending).FirstOrDefaultAsync();
            if (item == null)
            {
                throw new Exception("Don't exist order by id: " + idOrderPending);
            }
            if (item.Status.ToString().ToLower() != "pending")
            {
                throw new Exception("Can not change status. Because the order status isn't pendding.");
            }
            var checkEmoloyeeExist = await _context.Employees.Where(p => p.EmployeeId == idEmployee).FirstOrDefaultAsync();
            if (checkEmoloyeeExist == null)
            {
                throw new Exception($"Employe id not found");
            }
            item.EmployeeId = idOrderPending;
            item.Status = status;
            _context.OrderPendings.Update(item);
            return true;
        }
    }
}
