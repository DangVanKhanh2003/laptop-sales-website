using System;
using System.Collections.Generic;

namespace SellingElectronicWebsite.Entities;

public partial class AddressCustomer
{
    public int AddressCusId { get; set; }

    public string Province { get; set; } = null!;

    public string District { get; set; } = null!;

    public string Commune { get; set; } = null!;

    public string Street { get; set; } = null!;

    public string NumberHouse { get; set; } = null!;

    public string PhoneNumber { get; set; } = null!;

    public int? CustomerId { get; set; }

    public virtual Customer? Customer { get; set; }
}
