using System;
using System.Collections.Generic;

namespace SellingElectronicWebsite.Entities;

public partial class Order
{
    public int OrderId { get; set; }

    public int? CustomerId { get; set; }

    public int? EmployeeId { get; set; }

    public DateTime? OdertDate { get; set; }

    public int? StoreId { get; set; }

    public string Status { get; set; } = null!;

    public string? OrderType { get; set; }

    public DateTime? DateExport { get; set; }

    public int? OrderPendingId { get; set; }

    public virtual Customer? Customer { get; set; }

    public virtual Employee? Employee { get; set; }

    public virtual OrderPending? OrderPending { get; set; }

    public virtual ICollection<ProductOrder> ProductOrders { get; set; } = new List<ProductOrder>();

    public virtual Store? Store { get; set; }
}
