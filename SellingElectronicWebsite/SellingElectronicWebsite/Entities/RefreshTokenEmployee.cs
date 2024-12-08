using System;
using System.Collections.Generic;

namespace SellingElectronicWebsite.Entities;

public partial class RefreshTokenEmployee
{
    public Guid RefreshTokenEmployeeId { get; set; }

    public Guid AccEmpId { get; set; }

    public string? Token { get; set; }

    public string? JwtId { get; set; }

    public bool? IsUsed { get; set; }

    public bool? IsRevoked { get; set; }

    public DateTime? IssuedAt { get; set; }

    public DateTime? ExpiredAt { get; set; }

    public virtual AccountEmp AccEmp { get; set; } = null!;
}
