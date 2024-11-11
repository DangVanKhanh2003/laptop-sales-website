using System;
using System.Collections.Generic;

namespace SellingElectronicWebsite.Entities;

public partial class RefreshTokenCustomer
{
    public Guid RefreshTokenCustomerId { get; set; }

    public int CustomerId { get; set; }

    public string? Token { get; set; }

    public string? JwtId { get; set; }

    public bool? IsUsed { get; set; }

    public bool? IsRevoked { get; set; }

    public DateTime? IssuedAt { get; set; }

    public DateTime? ExpiredAt { get; set; }

    public string? Email { get; set; }

    public virtual Customer Customer { get; set; } = null!;
}
