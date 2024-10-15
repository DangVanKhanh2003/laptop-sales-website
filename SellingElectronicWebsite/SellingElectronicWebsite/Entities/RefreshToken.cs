using System;
using System.Collections.Generic;

namespace SellingElectronicWebsite.Entities;

public partial class RefreshToken
{
    public Guid Id { get; set; }

    public int? AccountId { get; set; }

    public string? Token { get; set; }

    public string? JwtId { get; set; }

    public bool? IsUsed { get; set; }

    public bool? IsRevoked { get; set; }

    public DateTime? IssuedAt { get; set; }

    public DateTime? ExpiredAt { get; set; }

    public virtual UserAccount? Account { get; set; }
}
