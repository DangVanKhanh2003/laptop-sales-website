namespace SellingElectronicWebsite.Model
{
    public class CommentModel
    {
        public int? CustomerId { get; set; }

        public int ProductId { get; set; }

        public string CommentDetail { get; set; } = null!;

        public int? ParentId { get; set; }

        public int? ToCustomerId { get; set; }

    }
}
