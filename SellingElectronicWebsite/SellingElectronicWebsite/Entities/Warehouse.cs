using System;
using System.Collections.Generic;

namespace SellingElectronicWebsite.Entities;

public partial class Warehouse
{
    public int WarehouseId { get; set; }

    public string? WarehouseName { get; set; }

    public int? AddressId { get; set; }

    public virtual Address? Address { get; set; }

    public virtual ICollection<WarehousesExport> WarehousesExports { get; set; } = new List<WarehousesExport>();

    public virtual ICollection<WarehousesImport> WarehousesImports { get; set; } = new List<WarehousesImport>();

    public virtual ICollection<WarehousesProduct> WarehousesProducts { get; set; } = new List<WarehousesProduct>();
}
