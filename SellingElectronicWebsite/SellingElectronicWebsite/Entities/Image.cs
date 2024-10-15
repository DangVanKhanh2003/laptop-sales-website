using System;
using System.Collections.Generic;

namespace SellingElectronicWebsite.Entities;

public partial class Image
{
    public int ImageId { get; set; }

    public string ImagePath { get; set; } = null!;

    public int RatingId { get; set; }

    public virtual Rating Rating { get; set; } = null!;
}
