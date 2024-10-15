using System;
using System.Collections.Generic;

namespace SellingElectronicWebsite.Entities;

public partial class ProductDetail
{
    public int DetailsId { get; set; }

    public int ProductId { get; set; }

    public string Detail { get; set; } = null!;

    public DateTime? CreatedAt { get; set; }

    public virtual Product Product { get; set; } = null!;
}
