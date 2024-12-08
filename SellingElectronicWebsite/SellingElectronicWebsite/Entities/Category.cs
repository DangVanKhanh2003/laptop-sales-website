using System;
using System.Collections.Generic;

namespace SellingElectronicWebsite.Entities;

public partial class Category
{
    public int CategoryId { get; set; }

    public string? CategoryName { get; set; }

    public string? CategoryIcon { get; set; }

    public virtual ICollection<Product> Products { get; set; } = new List<Product>();
}
