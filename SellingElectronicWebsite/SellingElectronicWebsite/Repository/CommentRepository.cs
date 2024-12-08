using AutoMapper;
using Microsoft.EntityFrameworkCore;
using SellingElectronicWebsite.Entities;
using SellingElectronicWebsite.Model;
using SellingElectronicWebsite.ViewModel;

namespace SellingElectronicWebsite.Repository
{
    public class CommentRepository : ICommentRepository
    {
        private SellingElectronicsContext _context;
        private readonly IMapper _mapper;


        public CommentRepository(SellingElectronicsContext context, IMapper mapper)
        {
            _context = context;
            _mapper = mapper;

        }
        public async Task<bool> AddComment(CommentModel model)
        {

            //check product
            var checkProduct = await _context.Products
                                                      .Where(p => p.ProductId == model.ProductId)
                                                      .FirstOrDefaultAsync();
            if (checkProduct == null)
            {
                throw new Exception("Product not exist!");
            }

            //check customer
            var checkCustomer = await _context.Customers
                                                      .Where(p => p.CustomerId == model.CustomerId)
                                                      .FirstOrDefaultAsync();
            if (checkCustomer == null)
            {
                throw new Exception("Customer not exist!");
            }

            //check parent comment
            if (model.ParentId != null)
            {
                var checkPartentComment = await _context.Comments
                                                            .Where(p => p.CommentId == model.ParentId && p.ProductId == model.ProductId)
                                                            .FirstOrDefaultAsync();
                
                
                if (checkPartentComment == null)
                {
                    throw new Exception("PartentId don't exist in this product!");
                }
                else
                {
                    // check toCustomer exist
                    var checkToCustomer = await _context.Customers
                                                            .Where(p => p.CustomerId == model.ToCustomerId)
                                                            .FirstOrDefaultAsync();
                    if (checkToCustomer == null)
                    {
                        throw new Exception("ToCustomerId don't exist!");
                    }

                    // check level of parent comment
                    // Does parenId of parent comment exist?. If exist => Parent of model = parent of parent comment.
                    if (checkPartentComment.ParentId != null)
                    {
                        model.ParentId = checkPartentComment.ParentId;
                    }
                }

            }

            // map from CommentModel to Comment
            Comment comment = _mapper.Map<Comment>(model); 

            // add to DB
            await _context.AddAsync(comment);

            return true;
        }

        public async Task<bool> DeleteByIdComment(int idComment)
        {
            // check comment
            var comment = await _context.Comments
                                                  .Where(p => p.CommentId == idComment)
                                                  .FirstOrDefaultAsync();
            if(comment == null)
            {
                throw new Exception("Comment don't exist!");
            }
            else
            {
                _context.Remove(comment);
                return true;
            }
        }

        public async Task<List<CommentVM>> GetAllByIdProduct(int idProduct)
        {
            //check product
            var checkProduct = await _context.Products
                                                      .Where(p => p.ProductId == idProduct)
                                                      .FirstOrDefaultAsync();
            if (checkProduct == null)
            {
                throw new Exception("Product not exist!");
            }
            
            //get comment level 1
            var commentLV1 = await _context.Comments
                                                    .Include(p => p.Customer)
                                                    .Where(p => p.ProductId == idProduct && p.ParentId == null) 
                                                    .ToListAsync();

            // map commentLV1 to CommentVM
            List<CommentVM> commentLv1VM = _mapper.Map<List<CommentVM>>(commentLV1);    
            // add sub comment for comments level 1
            foreach(CommentVM item in commentLv1VM)
            {
                var subComments = await _context.Comments
                                                         .Include(p => p.Customer)
                                                         .Where(p => p.ParentId == item.CommentId && p.ProductId == item.ProductId)
                                                         .ToListAsync();
                // add sub comment to each item
                item.subComments = _mapper.Map<List<CommentVM>>(subComments);
            }

            return commentLv1VM;
        }

        public async Task<CommentVM> UpdateCommentByIdComment(int idComment, string content)
        {
            // check comment
            var comment = await _context.Comments
                                                  .Include(p => p.Customer)
                                                  .Where(p => p.CommentId == idComment)
                                                  .FirstOrDefaultAsync();
            if (comment == null)
            {
                throw new Exception("Comment don't exist!");
            }
            else
            {
                comment.CommentDetail = content;
                _context.Update(comment);
                var commentVM = _mapper.Map<CommentVM>(comment);
                var subComments = await _context.Comments
                                                         .Include(p => p.Customer)
                                                         .Where(p => p.ParentId == commentVM.CommentId && p.ProductId == commentVM.ProductId)
                                                         .ToListAsync();
                // add sub comment to each item
                commentVM.subComments = _mapper.Map<List<CommentVM>>(subComments);
                return commentVM;
            }
        }
    }
}
