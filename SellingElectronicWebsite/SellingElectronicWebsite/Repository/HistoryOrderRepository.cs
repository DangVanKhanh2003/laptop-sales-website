using AutoMapper;
using Microsoft.EntityFrameworkCore;
using SellingElectronicWebsite.Entities;
using SellingElectronicWebsite.ViewModel;
using System.Globalization;

namespace SellingElectronicWebsite.Repository
{
    public class HistoryOrderRepository : IHistoryOrderRepository
    {
        private SellingElectronicsContext _context;
        private readonly IMapper _mapper;


        public HistoryOrderRepository(SellingElectronicsContext context, IMapper mapper)
        {
            _context = context;
            _mapper = mapper;

        }

        /// <summary>
        /// Get all cancel order by id customer
        /// </summary>
        /// <param name="sortByOrderDate">value: "timeDesc"/"timeAsc". Default = null</param>
        public async Task<List<CancelOrderVM>> GetAllCancelOrderByIdCustomer(int idCustomer, string sortByOrderDate = null)
        {

            List<CancelOrderVM> listCancelOrderVM = new List<CancelOrderVM>();

            //get all order cancel by orderPending table
            var listOrderPending = await _context.OrderPendings
                                                       .Include(p => p.Customer)
                                                       .Include(p => p.Employee)
                                                       .Where(p => p.Status.ToLower() == "cancel")
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
                                                             .Include (p => p.Color)
                                                             .ToListAsync();
                
                // create new CancelOrderVM
                CancelOrderVM newCancel = new CancelOrderVM();
                newCancel.OdertDate = item.OdertDate;
                if(item.EmployeeId != null)
                {
                    newCancel.ActorCancel = "Employee";
                }
                else
                {
                    newCancel.ActorCancel = "Customer";
                }
                
                newCancel.CancelProducts = _mapper.Map<List<ProductOrderCancelVM>>(listProductOrderPendingVM);
                //add newCancel to listCancelOrderVM
                listCancelOrderVM.Add(newCancel);
            }



            //get all order cancel by order table
            var listCancelByEmployee = await _context.Orders
                                                .Include(p => p.Customer)
                                                .Include(p => p.Employee)
                                                .Include(p => p.Store)
                                                .Include(p => p.Store.Address)
                                                .Where(p => p.Status.ToLower() == "cancel" && p.CustomerId == idCustomer)
                                                .ToListAsync();

          

            
            List<OrderVM> listOrderVM = _mapper.Map<List<OrderVM>>(listCancelByEmployee);
            // add product for list for order
            foreach (OrderVM item in listOrderVM)
            {
                var listProductOrder = await _context.ProductOrders
                                                             .Where(p => p.OrderId == item.OrderId)
                                                             .Include(p => p.Product)
                                                             .Include(p => p.Product.Category)
                                                             .Include(p => p.Color)
                                                             .ToListAsync();

                // create new CancelOrderVM
                CancelOrderVM newCancel = new CancelOrderVM();
                newCancel.OdertDate = item.OdertDate;
                newCancel.ActorCancel = "Employee";
                newCancel.CancelProducts = _mapper.Map<List<ProductOrderCancelVM>>(listProductOrder);
                //add newCancel to listCancelOrderVM
                listCancelOrderVM.Add(newCancel);
            }


            return listCancelOrderVM;
        }

        /// <summary>
        /// Get all success order by id customer
        /// </summary>
        /// <param name="sortByOrderDate">value: "timeDesc"/"timeAsc". Default = null</param>
        public async Task<List<OrderVM>> GetAllSuccessOrderByIdCustomer(int idCustomer, string sortByOrderDate = null)
        {

            var listOrder = await _context.Orders
                                                .Include(p => p.Customer)
                                                .Include(p => p.Employee)
                                                .Include(p => p.Store)
                                                .Include(p => p.Store.Address)
                                                .Where(p => p.Status.ToLower() == "approve" && p.CustomerId == idCustomer)
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
                    if(itemOrder.OdertDate != null)
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
