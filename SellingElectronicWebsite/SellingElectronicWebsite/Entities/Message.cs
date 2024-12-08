using System;
using System.Collections.Generic;

namespace SellingElectronicWebsite.Entities;

public partial class Message
{
    public int MessagesId { get; set; }

    public int? CustomerId { get; set; }

    public int? EmployeeId { get; set; }

    public string? MessageText { get; set; }

    public string? PersonSend { get; set; }

    public DateTime? ChatTime { get; set; }

    public virtual Customer? Customer { get; set; }

    public virtual Employee? Employee { get; set; }
}
