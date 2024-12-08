using System;
using System.Collections.Generic;

namespace SellingElectronicWebsite.Entities;

public partial class UserAccount
{
    public int Id { get; set; }

    public string Username { get; set; } = null!;

    public string Password { get; set; } = null!;

    public string FullName { get; set; } = null!;

    public string Email { get; set; } = null!;

}
