using SellingElectronicWebsite.Model;
using SellingElectronicWebsite.ViewModel;

namespace SellingElectronicWebsite.Repository
{
    public interface ICommentRepository
    {
        public Task<List<CommentVM>> GetAllByIdProduct(int idProduct);
        public Task<bool> AddComment(CommentModel model);
        public Task<CommentVM> UpdateCommentByIdComment(int idComment, string content);
        public Task<bool> DeleteByIdComment(int idComment);
    }
}
