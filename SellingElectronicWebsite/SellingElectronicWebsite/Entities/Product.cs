using System;
using System.Collections.Generic;

namespace SellingElectronicWebsite.Entities;

public partial class Product
{
    public int ProductId { get; set; }

    public string ProductName { get; set; } = null!;

    public string Brand { get; set; } = null!;

    public string Series { get; set; } = null!;

    public decimal Price { get; set; }

    public int? CategoryId { get; set; }

    public string? MainImg { get; set; }

    public virtual Category? Category { get; set; }

    public virtual ICollection<Comment> Comments { get; set; } = new List<Comment>();

    public virtual ICollection<ImageProduct> ImageProducts { get; set; } = new List<ImageProduct>();

    public virtual ICollection<ProductDetail> ProductDetails { get; set; } = new List<ProductDetail>();

    public virtual ICollection<ProductOrderPending> ProductOrderPendings { get; set; } = new List<ProductOrderPending>();

    public virtual ICollection<ProductOrder> ProductOrders { get; set; } = new List<ProductOrder>();

    public virtual ICollection<ProductSpecifiaction> ProductSpecifiactions { get; set; } = new List<ProductSpecifiaction>();

    public virtual ICollection<Rating> Ratings { get; set; } = new List<Rating>();

    public virtual ICollection<Sale> Sales { get; set; } = new List<Sale>();

    public virtual ICollection<ShoppingCart> ShoppingCarts { get; set; } = new List<ShoppingCart>();

    public virtual ICollection<StoresProduct> StoresProducts { get; set; } = new List<StoresProduct>();

    public virtual ICollection<WarehousesExportProduct> WarehousesExportProducts { get; set; } = new List<WarehousesExportProduct>();

    public virtual ICollection<WarehousesImportProduct> WarehousesImportProducts { get; set; } = new List<WarehousesImportProduct>();

    public virtual ICollection<WarehousesProduct> WarehousesProducts { get; set; } = new List<WarehousesProduct>();
}
