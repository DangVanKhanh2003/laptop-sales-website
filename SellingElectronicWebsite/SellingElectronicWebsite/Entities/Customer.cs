using System;
using System.Collections.Generic;

namespace SellingElectronicWebsite.Entities;

public partial class Customer
{
    public int CustomerId { get; set; }

    public string? FullName { get; set; }

    public string? PhoneNumber { get; set; }

    public int? AddressId { get; set; }

    public virtual ICollection<AccountCustomer> AccountCustomers { get; set; } = new List<AccountCustomer>();

    public virtual Address? Address { get; set; }

    public virtual ICollection<AddressCustomer> AddressCustomers { get; set; } = new List<AddressCustomer>();

    public virtual ICollection<Comment> CommentCustomers { get; set; } = new List<Comment>();

    public virtual ICollection<Comment> CommentToCustomers { get; set; } = new List<Comment>();

    public virtual ICollection<Message> Messages { get; set; } = new List<Message>();

    public virtual ICollection<OrderPending> OrderPendings { get; set; } = new List<OrderPending>();

    public virtual ICollection<Order> Orders { get; set; } = new List<Order>();

    public virtual ICollection<Rating> Ratings { get; set; } = new List<Rating>();

    public virtual ICollection<RefreshTokenCustomer> RefreshTokenCustomers { get; set; } = new List<RefreshTokenCustomer>();

    public virtual ICollection<ShoppingCart> ShoppingCarts { get; set; } = new List<ShoppingCart>();
}
