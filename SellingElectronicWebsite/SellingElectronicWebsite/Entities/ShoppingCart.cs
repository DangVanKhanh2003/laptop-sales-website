using System;
using System.Collections.Generic;

namespace SellingElectronicWebsite.Entities;

public partial class ShoppingCart
{
    public int CustomerId { get; set; }

    public int ProductId { get; set; }

    public int Amount { get; set; }

    public int ColorId { get; set; }

    public int ShoppingCartId { get; set; }

    public virtual Color Color { get; set; } = null!;

    public virtual Customer Customer { get; set; } = null!;

    public virtual Product Product { get; set; } = null!;
}
