using System;
using System.Collections.Generic;

namespace SellingElectronicWebsite.Entities;

public partial class Comment
{
    public int CommentId { get; set; }

    public int? CustomerId { get; set; }

    public int ProductId { get; set; }

    public string CommentDetail { get; set; } = null!;

    public DateTime? CommentDate { get; set; }

    public int? ParentId { get; set; }

    public int? ToCustomerId { get; set; }

    public virtual Customer? Customer { get; set; }

    public virtual ICollection<Comment> InverseParent { get; set; } = new List<Comment>();

    public virtual Comment? Parent { get; set; }

    public virtual Product Product { get; set; } = null!;

    public virtual Customer? ToCustomer { get; set; }
}
