using System;
using System.Collections.Generic;

namespace SellingElectronicWebsite.Entities;

public partial class Rating
{
    public int RatingId { get; set; }

    public int? CustomerId { get; set; }

    public int ProductId { get; set; }

    public int? RatingValue { get; set; }

    public string? RatingDetail { get; set; }

    public DateTime? RatingDate { get; set; }

    public virtual Customer? Customer { get; set; }

    public virtual ICollection<Image> Images { get; set; } = new List<Image>();

    public virtual Product Product { get; set; } = null!;
}
