using System;
using System.Collections.Generic;

namespace SellingElectronicWebsite.Entities;

public partial class Color
{
    public int ColorId { get; set; }

    public string ColorName { get; set; } = null!;

    public virtual ICollection<ImageProduct> ImageProducts { get; set; } = new List<ImageProduct>();

    public virtual ICollection<ProductOrderPending> ProductOrderPendings { get; set; } = new List<ProductOrderPending>();

    public virtual ICollection<ProductOrder> ProductOrders { get; set; } = new List<ProductOrder>();

    public virtual ICollection<ShoppingCart> ShoppingCarts { get; set; } = new List<ShoppingCart>();

    public virtual ICollection<StoresProduct> StoresProducts { get; set; } = new List<StoresProduct>();

    public virtual ICollection<WarehousesProduct> WarehousesProducts { get; set; } = new List<WarehousesProduct>();
}
