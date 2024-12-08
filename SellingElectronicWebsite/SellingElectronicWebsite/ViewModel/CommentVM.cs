namespace SellingElectronicWebsite.ViewModel
{
    public class CommentVM
    {
        public int CommentId { get; set; }

        public CustomerVM Customer { get; set; }

        public int ProductId { get; set; }

        public string CommentDetail { get; set; } = null!;

        public DateTime? CommentDate { get; set; }

        public int? ParentId { get; set; }
        public CustomerVM ToCustomer { get; set; }


        public List<CommentVM> subComments { get; set; }
    }
}
