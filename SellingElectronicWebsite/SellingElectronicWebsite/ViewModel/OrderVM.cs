namespace SellingElectronicWebsite.ViewModel
{
    public class OrderVM
    {
        public int OrderId { get; set; }

        public int? CustomerId { get; set; }
        public string CustomerName { get; set; }

        public int? EmployeeId { get; set; }
        public string EmployeeName { get; set; }

        public DateTime? OdertDate { get; set; }

        public StoreVM Store{ get; set; }

        public string Status { get; set; } = null!;

        public string? OrderType { get; set; }

        public DateTime? DateExport { get; set; }

        public int? OrderPendingId { get; set; }

        public List<ProductOrderVM> ListProductOrder {  get; set; }
        public OrderVM() { }
        public OrderVM(int orderId, int? customerId, string customerName, int? employeeId, string employeeName,
            DateTime? odertDate, StoreVM store, string status, string? orderType, DateTime? dateExport, int? orderPendingId)
        {
            OrderId = orderId;
            CustomerId = customerId;
            CustomerName = customerName;
            EmployeeId = employeeId;
            EmployeeName = employeeName;
            OdertDate = odertDate;
            Store = store;
            Status = status;
            OrderType = orderType;
            DateExport = dateExport;
            OrderPendingId = orderPendingId;
        }
    }
}
