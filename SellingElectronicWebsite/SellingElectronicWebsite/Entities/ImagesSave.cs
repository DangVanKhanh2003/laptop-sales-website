using System;
using System.Collections.Generic;

namespace SellingElectronicWebsite.Entities;

public partial class ImagesSave
{
    public int Id { get; set; }

    public string? FileName { get; set; }

    public byte[]? ImageData { get; set; }

    public string? FileExtension { get; set; }
}
