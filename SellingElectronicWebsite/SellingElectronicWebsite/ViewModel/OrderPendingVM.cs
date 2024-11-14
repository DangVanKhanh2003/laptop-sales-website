using SellingElectronicWebsite.Model;

namespace SellingElectronicWebsite.ViewModel
{
    public class OrderPendingVM
    {
        

        public int OrderPendingId { get; set; }

        public String? CustomerName { get; set; }
        public int? CustomerId { get; set; }
        public int? EmployeeId { get; set; }

        public String? EmployeeName { get; set; }

        public DateTime? OdertDate { get; set; }

        public string? Status { get; set; }

        public List<ProductOrderPendingVM> ListProductOrederPending { get; set; }
        public OrderPendingVM() { }
        public OrderPendingVM(int orderPendingId, string? customerName, int? customerId,
             int? employeeId, string? employeeName, DateTime? odertDate, string? status)
        {
            OrderPendingId = orderPendingId;
            CustomerName = customerName;
            CustomerId = customerId;
            EmployeeId = employeeId;
            EmployeeName = employeeName;
            OdertDate = odertDate;
            Status = status;
        }

        public OrderPendingVM( int orderPendingId, string? customerName, int? customerId, 
            int? employeeId, string? employeeName, DateTime? odertDate, string? status, 
            List<ProductOrderPendingVM> listProductOrederPending)
        {
            OrderPendingId = orderPendingId;
            CustomerName = customerName;
            CustomerId = customerId;
            EmployeeId = employeeId;
            EmployeeName = employeeName;
            OdertDate = odertDate;
            Status = status;
            ListProductOrederPending = listProductOrederPending;
        }
    }
}
