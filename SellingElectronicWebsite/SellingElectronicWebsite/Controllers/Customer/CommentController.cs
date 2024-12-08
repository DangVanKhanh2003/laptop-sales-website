using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using SellingElectronicWebsite.Model;
using SellingElectronicWebsite.UnitOfWork;
using SellingElectronicWebsite.ViewModel;

namespace SellingElectronicWebsite.Controllers.Customer
{
    [Route("api/[controller]")]
    [ApiController]
    public class CommentController : ControllerBase
    {
        private IUnitOfWork _uow;

        public CommentController(IUnitOfWork uow)
        {
            _uow = uow;
        }

        /// <summary>
        /// get all comment by id product
        /// </summary>
        /// <param name="idProduct"></param>
        /// <returns></returns>
        [HttpGet]
        public async Task<IActionResult> GetAllByIdProduct(int idProduct)
        {
            try
            {
                var result = await _uow.Comments.GetAllByIdProduct(idProduct);
                return Ok(result);
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);

            }
        }

        /// <summary>
        /// add new comment
        /// </summary>
        /// <param name="model">"parentId", "toCustomerId": can null. If comment is sub comment. "toCustomerId" and "parentId" must not null </param>
        /// <returns></returns>
        [HttpPost]
        public async Task<IActionResult> AddComment(CommentModel model)
        {
            try
            {
                _uow.CreateTransaction();
                if (model.ParentId == 0)
                {
                    model.ParentId = null;
                }
                if (model.ToCustomerId == 0)
                {
                    model.ToCustomerId = null;
                }
                var result = await _uow.Comments.AddComment(model);
                await _uow.Save();
                _uow.Commit();
                return Ok(result);
            }
            catch (Exception ex)
            {
                _uow.Rollback();
                return BadRequest(ex.Message);

            }
        }

        /// <summary>
        /// Update content of comment by id comment
        /// </summary>
        /// <param name="idComment"></param>
        /// <param name="content"></param>
        /// <returns></returns>
        [HttpPut("{idComment}")]
        public async Task<IActionResult> UpdateCommentByIdComment(int idComment, string content)
        {
            try
            {
                _uow.CreateTransaction();
                var result = await _uow.Comments.UpdateCommentByIdComment(idComment, content);
                await _uow.Save();
                _uow.Commit();
                return Ok(result);
            }
            catch (Exception ex)
            {
                _uow.Rollback();
                return BadRequest(ex.Message);

            }
        }

        /// <summary>
        /// Delete comment by id comment
        /// </summary>
        /// <param name="idComment"></param>
        /// <returns></returns>
        [HttpDelete]
        public async Task<IActionResult> DeleteByIdComment(int idComment)
        {
            try
            {
                _uow.CreateTransaction();
                var result = await _uow.Comments.DeleteByIdComment(idComment);
                await _uow.Save();
                _uow.Commit();
                return Ok(result);
            }
            catch (Exception ex)
            {
                _uow.Rollback();
                return BadRequest(ex.Message);

            }
        }
    }
}
