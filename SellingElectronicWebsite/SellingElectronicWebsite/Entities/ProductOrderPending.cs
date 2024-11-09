using System;
using System.Collections.Generic;

namespace SellingElectronicWebsite.Entities;

public partial class ProductOrderPending
{
    public int ProductOrderPendingId { get; set; }

    public int? OrderPendingId { get; set; }

    public int? ProductId { get; set; }

    public int Amount { get; set; }

    public int? ColorId { get; set; }

    public virtual Color? Color { get; set; }

    public virtual OrderPending? OrderPending { get; set; }

    public virtual Product? Product { get; set; }
}
