using System;
using System.Collections.Generic;

namespace SellingElectronicWebsite.Entities;

public partial class Employee
{
    public int EmployeeId { get; set; }

    public string FullName { get; set; } = null!;

    public string Email { get; set; } = null!;

    public string PhoneNumber { get; set; } = null!;

    public int? PositionId { get; set; }

    public int? StoreId { get; set; }

    public int? AddressId { get; set; }

    public virtual ICollection<AccountEmp> AccountEmps { get; set; } = new List<AccountEmp>();

    public virtual Address? Address { get; set; }

    public virtual ICollection<Message> Messages { get; set; } = new List<Message>();

    public virtual ICollection<OrderPending> OrderPendings { get; set; } = new List<OrderPending>();

    public virtual ICollection<Order> Orders { get; set; } = new List<Order>();

    public virtual Address? Position { get; set; }

    public virtual Store? Store { get; set; }

    public virtual ICollection<StoreImport> StoreImports { get; set; } = new List<StoreImport>();

    public virtual ICollection<WarehousesExport> WarehousesExports { get; set; } = new List<WarehousesExport>();

    public virtual ICollection<WarehousesImport> WarehousesImports { get; set; } = new List<WarehousesImport>();
}
