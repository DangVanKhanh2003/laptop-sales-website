using System;
using System.Collections.Generic;

namespace SellingElectronicWebsite.Entities;

public partial class Role
{
    public Guid RolesId { get; set; }

    public string RolesName { get; set; } = null!;

    public virtual ICollection<TypeAccount> TypeAccs { get; set; } = new List<TypeAccount>();
}
