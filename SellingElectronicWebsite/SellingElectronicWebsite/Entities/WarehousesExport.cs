using System;
using System.Collections.Generic;

namespace SellingElectronicWebsite.Entities;

public partial class WarehousesExport
{
    public int WarehousesExportId { get; set; }

    public int? WarehouseId { get; set; }

    public int? StoreId { get; set; }

    public DateTime TimeAt { get; set; }

    public int? EmployeeId { get; set; }

    public virtual Employee? Employee { get; set; }

    public virtual Store? Store { get; set; }

    public virtual ICollection<StoreImport> StoreImports { get; set; } = new List<StoreImport>();

    public virtual Warehouse? Warehouse { get; set; }

    public virtual ICollection<WarehousesExportProduct> WarehousesExportProducts { get; set; } = new List<WarehousesExportProduct>();
}
