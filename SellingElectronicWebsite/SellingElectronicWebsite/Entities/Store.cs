using System;
using System.Collections.Generic;

namespace SellingElectronicWebsite.Entities;

public partial class Store
{
    public int StoreId { get; set; }

    public string? StoreName { get; set; }

    public int? AddressId { get; set; }

    public virtual Address? Address { get; set; }

    public virtual ICollection<Employee> Employees { get; set; } = new List<Employee>();

    public virtual ICollection<Order> Orders { get; set; } = new List<Order>();

    public virtual ICollection<StoreImport> StoreImports { get; set; } = new List<StoreImport>();

    public virtual ICollection<StoresProduct> StoresProducts { get; set; } = new List<StoresProduct>();

    public virtual ICollection<WarehousesExport> WarehousesExports { get; set; } = new List<WarehousesExport>();
}
