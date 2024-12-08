using System;
using System.Collections.Generic;

namespace SellingElectronicWebsite.Entities;

public partial class StoreImport
{
    public int StoreImportId { get; set; }

    public int? WarehousesExportId { get; set; }

    public int? StoreId { get; set; }

    public DateTime TimeAt { get; set; }

    public int? EmployeeId { get; set; }

    public bool Status { get; set; }

    public virtual Employee? Employee { get; set; }

    public virtual Store? Store { get; set; }

    public virtual WarehousesExport? WarehousesExport { get; set; }
}
