using System;
using System.Collections.Generic;

namespace SellingElectronicWebsite.Entities;

public partial class WarehousesProduct
{
    public int WarehousesProductId { get; set; }

    public int WarehouseId { get; set; }

    public int ProductId { get; set; }

    public int ColorId { get; set; }

    public int? Amount { get; set; }

    public virtual Color Color { get; set; } = null!;

    public virtual Product Product { get; set; } = null!;

    public virtual Warehouse Warehouse { get; set; } = null!;
}
