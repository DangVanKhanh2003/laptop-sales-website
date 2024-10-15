using System;
using System.Collections.Generic;

namespace SellingElectronicWebsite.Entities;

public partial class Color
{
    public int ColorId { get; set; }

    public string ColorName { get; set; } = null!;

    public virtual ICollection<ImageProduct> ImageProducts { get; set; } = new List<ImageProduct>();
}
