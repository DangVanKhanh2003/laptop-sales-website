using System;
using System.Collections.Generic;

namespace SellingElectronicWebsite.Entities;

public partial class WarehousesImport
{
    public int WarehousesImportId { get; set; }

    public int? WarehouseId { get; set; }

    public DateTime TimeAt { get; set; }

    public int? EmployeeId { get; set; }

    public virtual Employee? Employee { get; set; }

    public virtual Warehouse? Warehouse { get; set; }

    public virtual ICollection<WarehousesImportProduct> WarehousesImportProducts { get; set; } = new List<WarehousesImportProduct>();
}
