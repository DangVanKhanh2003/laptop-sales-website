using System;
using System.Collections.Generic;

namespace SellingElectronicWebsite.Entities;

public partial class TypeAccount
{
    public Guid TypeAccId { get; set; }

    public string TypeAccName { get; set; } = null!;

    public virtual ICollection<AccountEmp> AccountEmps { get; set; } = new List<AccountEmp>();

    public virtual ICollection<Role> Roles { get; set; } = new List<Role>();
}
