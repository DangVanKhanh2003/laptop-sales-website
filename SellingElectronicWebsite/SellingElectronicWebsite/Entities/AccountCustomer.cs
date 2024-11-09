using System;
using System.Collections.Generic;

namespace SellingElectronicWebsite.Entities;

public partial class AccountCustomer
{
    public Guid AccCustomerId { get; set; }

    public int CustomerId { get; set; }

    public string Password { get; set; } = null!;

    public string Email { get; set; } = null!;

    public virtual Customer Customer { get; set; } = null!;
}
