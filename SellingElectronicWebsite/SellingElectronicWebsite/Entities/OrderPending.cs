using System;
using System.Collections.Generic;

namespace SellingElectronicWebsite.Entities;

public partial class OrderPending
{
    public int OrderPendingId { get; set; }

    public int? CustomerId { get; set; }

    public int? EmployeeId { get; set; }

    public DateTime? OdertDate { get; set; }

    public string? Status { get; set; }

    public virtual Customer? Customer { get; set; }

    public virtual Employee? Employee { get; set; }

    public virtual ICollection<Order> Orders { get; set; } = new List<Order>();

    public virtual ICollection<ProductOrderPending> ProductOrderPendings { get; set; } = new List<ProductOrderPending>();
}
