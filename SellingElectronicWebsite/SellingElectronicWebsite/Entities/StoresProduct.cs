using System;
using System.Collections.Generic;

namespace SellingElectronicWebsite.Entities;

public partial class StoresProduct
{
    public int StoresProductId { get; set; }

    public int StoreId { get; set; }

    public int ProductId { get; set; }

    public int ColorId { get; set; }

    public int? Amount { get; set; }

    public virtual Color Color { get; set; } = null!;

    public virtual Product Product { get; set; } = null!;

    public virtual Store Store { get; set; } = null!;
}
