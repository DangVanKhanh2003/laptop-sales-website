using System;
using System.Collections.Generic;

namespace SellingElectronicWebsite.Entities;

public partial class WarehousesExportProduct
{
    public int WarehousesExportProductId { get; set; }

    public int? WarehousesExportId { get; set; }

    public int? ProductId { get; set; }

    public int Amount { get; set; }

    public virtual Product? Product { get; set; }

    public virtual WarehousesExport? WarehousesExport { get; set; }
}
