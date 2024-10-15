using System;
using System.Collections.Generic;

namespace SellingElectronicWebsite.Entities;

public partial class LoaiSanPham
{
    public string MaLoai { get; set; } = null!;

    public string? TenLoai { get; set; }

    public virtual ICollection<SanPham> SanPhams { get; set; } = new List<SanPham>();
}
