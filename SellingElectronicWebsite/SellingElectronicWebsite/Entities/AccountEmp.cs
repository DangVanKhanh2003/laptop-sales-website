using System;
using System.Collections.Generic;

namespace SellingElectronicWebsite.Entities;

public partial class AccountEmp
{
    public Guid AccEmpId { get; set; }

    public int EmployeeId { get; set; }

    public string Password { get; set; } = null!;

    public Guid? TypeAccId { get; set; }

    public virtual Employee Employee { get; set; } = null!;

    public virtual TypeAccount? TypeAcc { get; set; }
}
