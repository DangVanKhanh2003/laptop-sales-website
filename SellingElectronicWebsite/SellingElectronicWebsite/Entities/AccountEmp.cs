using System;
using System.Collections.Generic;

namespace SellingElectronicWebsite.Entities;

public partial class AccountEmp
{
    public Guid AccEmpId { get; set; }

    public int EmployeeId { get; set; }

    public string Password { get; set; } = null!;

    public Guid? TypeAccId { get; set; }

    public string Email { get; set; } = null!;

    public virtual Employee Employee { get; set; } = null!;

    public virtual ICollection<RefreshTokenEmployee> RefreshTokenEmployees { get; set; } = new List<RefreshTokenEmployee>();

    public virtual TypeAccount? TypeAcc { get; set; }
}
