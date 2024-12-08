using System;
using System.Collections.Generic;

namespace SellingElectronicWebsite.Entities;

public partial class WarehousesImportProduct
{
    public int WarehousesImportProductId { get; set; }

    public int? WarehousesImportId { get; set; }

    public int? ProductId { get; set; }

    public int Amount { get; set; }

    public virtual Product? Product { get; set; }

    public virtual WarehousesImport? WarehousesImport { get; set; }
}
