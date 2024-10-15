using System;
using System.Collections.Generic;

namespace SellingElectronicWebsite.Entities;

public partial class Sale
{
    public int SaleId { get; set; }

    public int ProductId { get; set; }

    public int? NumProduct { get; set; }

    public DateTime StartAt { get; set; }

    public DateTime EndAt { get; set; }

    public int PercentSale { get; set; }

    public int? NumProductSold { get; set; }

    public virtual Product Product { get; set; } = null!;
}
