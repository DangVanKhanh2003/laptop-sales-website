using System;
using System.Collections.Generic;

namespace SellingElectronicWebsite.Entities;

public partial class Position
{
    public int PositionId { get; set; }

    public string PositionName { get; set; } = null!;

    public int? DepartmentId { get; set; }

    public virtual Department? Department { get; set; }
}
