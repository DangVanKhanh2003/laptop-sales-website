using System;
using System.Collections.Generic;

namespace SellingElectronicWebsite.Entities;

public partial class ProductSpecifiaction
{
    public int SpecifiactionsId { get; set; }

    public string SpecType { get; set; } = null!;

    public string Description { get; set; } = null!;

    public int ProductId { get; set; }

    public virtual Product Product { get; set; } = null!;
}
