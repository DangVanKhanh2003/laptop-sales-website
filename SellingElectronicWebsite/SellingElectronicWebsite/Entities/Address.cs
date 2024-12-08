using System;
using System.Collections.Generic;

namespace SellingElectronicWebsite.Entities;

public partial class Address
{
    public int AddressId { get; set; }

    public string Province { get; set; } = null!;

    public string District { get; set; } = null!;

    public string Commune { get; set; } = null!;

    public string Street { get; set; } = null!;

    public string NumberHouse { get; set; } = null!;

    public virtual ICollection<Customer> Customers { get; set; } = new List<Customer>();

    public virtual ICollection<Employee> EmployeeAddresses { get; set; } = new List<Employee>();

    public virtual ICollection<Employee> EmployeePositions { get; set; } = new List<Employee>();

    public virtual ICollection<Store> Stores { get; set; } = new List<Store>();

    public virtual ICollection<Warehouse> Warehouses { get; set; } = new List<Warehouse>();
}
