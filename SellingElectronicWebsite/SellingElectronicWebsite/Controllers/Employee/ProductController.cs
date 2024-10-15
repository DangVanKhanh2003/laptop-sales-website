using AutoMapper;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using SellingElectronicWebsite.Entities;
using SellingElectronicWebsite.Model;
using SellingElectronicWebsite.Repository;
using SellingElectronicWebsite.ViewModel;
using SellingElectronicWebsite.UnitOfWork;
using Microsoft.AspNetCore.Http.HttpResults;

namespace SellingElectronicWebsite.Controllers.Employee
{
    [Route("api/employee/[controller]")]
    [ApiController]
    public class ProductController : ControllerBase
    {
        private IUnitOfWork _uow;

        public ProductController(IUnitOfWork uow)
        {
            _uow = uow;
        }
        /// <summary>
        /// List all products.
        /// </summary>
        /// 
        /// <remarks>
        ///  In default, value of sortBy is null.If sortBy is null, api will return product sort by name ascending.
        ///  If you want to sort, you can enter value for "sortBy" parameter.
        /// </remarks>
        /// 
        /// <param name="sortBy">sortBy: price_desc/price_asc/name_desc/null(default: sort by name asc)</param>
        [HttpGet("get all product")]
        public async Task<IActionResult> GetAll(string sortBy = null)
        {
            try
            {
                var data = await _uow.Products.GetAll(sortBy);
                if (data == null)
                {
                    return NotFound();
                }
                return Ok(data); // Return the data in the response
            }
            catch
            {
                return StatusCode(StatusCodes.Status500InternalServerError);
            }
        }

        /// <summary>
        /// Get products by id.
        /// </summary>

        [HttpGet("{id}")]
        public async Task<IActionResult> GetById(int id)
        {
            try
            {
                var data = await _uow.Products.GetById(id);
                if (data == null)
                {
                    return NotFound();
                }
                return Ok(data);
            }
            catch
            {
                return StatusCode(StatusCodes.Status500InternalServerError);
            }
        }
        /// <summary>
        /// Count products.
        /// </summary>
        /// 
        [HttpGet("count")]
        public async Task<IActionResult> CountProducts()
        {
            try
            {
                var count = await _uow.Products.CountProducts();
                return Ok(count);
            }
            catch
            {
                return StatusCode(StatusCodes.Status500InternalServerError);
            }
        }

        /// <summary>
        /// List all products by page.
        /// </summary>
        /// 
        /// <remarks>
        /// Enter pageIndex, pageSize, sortBy. Api will return list products and sort(if sortBy != null).
        /// </remarks>
        /// 
        /// <param name="sortBy">sortBy: price_desc/price_asc/name_desc/null(default: sort by name asc)</param>

        [HttpGet("page")]
        public async Task<IActionResult> GetByPage(int pageIndex = 1, int pageSize = 10, string sortBy = null)
        {
            try
            {
                var data = await _uow.Products.GetByPage(pageIndex, pageSize, sortBy);
                if (data == null)
                {
                    return NotFound();
                }
                return Ok(data);
            }
            catch
            {
                return StatusCode(StatusCodes.Status500InternalServerError);
            }
        }

        /// <summary>
        /// Add new product. 
        /// </summary>
        /// <remarks>mainImg used for show image product in the card product of list product(mainImg is link img)</remarks>

        [HttpPost]
        public async Task<IActionResult> Add(ProductModel model)
        {
            try
            {
                _uow.CreateTransaction();
                var checkName = await _uow.Products.GetByName(model.ProductName);

                if (checkName != null)
                {
                    return BadRequest("The product name already exists.");
                }
                var checkCatagory = await _uow.Products.CategoryExists(model.CategoryId);
                if (checkCatagory == false)
                {
                    return BadRequest("The category id don't already exists.");
                }
                if (model.Price < 0)
                {
                    return BadRequest("The price invalid.");

                }
                var result = await _uow.Products.Add(model);

                await _uow.Save();
                _uow.Commit();
                return Ok(result);
            }
            catch
            {
                _uow.Rollback();
                return StatusCode(StatusCodes.Status500InternalServerError);

            }
        }
        /// <summary>
        /// Update product
        /// </summary>
        /// 
        /// <remarks>
        /// server find prouduct by id(input) and update the product. mainImg used for show image product in the card product of list product(mainImg is link img)
        /// </remarks>
     
        [HttpPut]
        public async Task<IActionResult> Update(ProductModel model, int id)
        {
            try
            {
                _uow.CreateTransaction();

                var checkName = await _uow.Products.GetByName(model.ProductName);

                if (checkName != null && id != checkName.ProductId)
                {
                    return BadRequest("The product name already exists.");
                }

                var checkCatagory = await _uow.Products.CategoryExists(model.CategoryId);
                if (checkCatagory == false)
                {
                    return BadRequest("The category id don't already exists.");
                }

                if (model.Price < 0)
                {
                    return BadRequest("The price invalid.");

                }

                var result = await _uow.Products.Update(model, id);

                if (result == false)
                {
                    return NotFound("No product found with id: " + id);
                }
                await _uow.Save();
                _uow.Commit();
                return Ok(result);
            }
            catch
            {
                _uow.Rollback();

                return StatusCode(StatusCodes.Status500InternalServerError);

            }
        }
        /// <summary>
        /// Delete product.
        /// </summary>
        /// 
        /// <remarks>
        /// Server find product and delete.
        /// </remarks>
      
        [HttpDelete]
        public async Task<IActionResult> Delete(int id)
        {
            try
            {
                _uow.CreateTransaction();

                var result = await _uow.Products.Delete(id);
                if (result == false)
                {
                    return NotFound("No product found with id: " + id);
                }
                await _uow.Save();
                _uow.Commit();
                return Ok(result);
            }
            catch
            {
                _uow.Rollback();
                return StatusCode(StatusCodes.Status500InternalServerError);

            }
        }


        /// <summary>
        /// get all colors of product.
        /// </summary>
        [HttpGet("get all color of product")]
        public async Task<IActionResult> GetAllcolor(int ProudctId)
        {
            try
            {
                var colors = await _uow.Products.GetAllColor(ProudctId);
                return Ok(colors);
            }
            catch
            {
                return StatusCode(StatusCodes.Status500InternalServerError);

            }
            
        }
        //image

        [HttpGet("Get all images by id product")]
        public async Task<IActionResult> GetImgsByProduct(int ProductId)
        {
            try
            {
                var imgs = await _uow.Products.GetImgByIdProduct(ProductId);

                return Ok(imgs);
            }
            catch
            {
                return StatusCode(StatusCodes.Status500InternalServerError);

            }
           

        }
        /// <summary>
        /// add a list images of product.
        /// </summary>
        ///  <param name="models"> Enter a list images</param>
        [HttpPost("post list images for product")]
        public async Task<IActionResult> AddImgsForProduct(List<ImageProductsModel> models)
        {
            try
            {
                _uow.CreateTransaction();
                await _uow.Products.AddImgs(models);
                await _uow.Save();

                _uow.Commit();

                return Ok();
            }
            catch
            {
                _uow.Rollback();
                return StatusCode(StatusCodes.Status500InternalServerError);

            }
            
        }
        /// <summary>
        /// Delete all images of product, and then add new list images of product.
        /// </summary>
        [HttpPut("Update list image of product")]
        public async Task<IActionResult> UpdateImgs(List<ImageProductsModel> models, int idProduct)
        {
            try
            {
                _uow.CreateTransaction();
                await _uow.Products.UpdateImgs(models, idProduct);
                await _uow.Save();

                _uow.Commit();

                return Ok();
            }
            catch
            {
                _uow.Rollback();
                return StatusCode(StatusCodes.Status500InternalServerError);

            }

        }

        [HttpDelete("Delete image by idImg")]
        public async Task<IActionResult> DeleteImgByIdImg(int idImg)
        {
            try
            {
                _uow.CreateTransaction();
                var result = await _uow.Products.DeleteImgByIdImg(idImg);
                if (result == false)
                {
                    return NotFound("No image found with id: " + idImg);
                }
                await _uow.Save();

                _uow.Commit();

                return Ok();
            }
            catch
            {
                _uow.Rollback();
                return StatusCode(StatusCodes.Status500InternalServerError);

            }
        }
        /// <summary>
        /// Delete all images of product.
        /// </summary>
        [HttpDelete("Delete list images of product")]
        public async Task<IActionResult> DeleteAllImgByIdProduct(int idProduct)
        {
            try
            {
                _uow.CreateTransaction();
                await _uow.Products.DeleteAllImgByIdProduct(idProduct);
                await _uow.Save();
                _uow.Commit();

                return Ok();
            }
            catch
            {
                _uow.Rollback();
                return StatusCode(StatusCodes.Status500InternalServerError);

            }
        }

        //Specification

        [HttpGet("Get all specifications by id product")]
        public async Task<IActionResult> GetSpesByProduct(int ProductId)
        {
            try
            {
                var spes = await _uow.Products.GetSpeciByIdProduct(ProductId);

                return Ok(spes);
            }
            catch
            {
                return StatusCode(StatusCodes.Status500InternalServerError);

            }


        }
        /// <summary>
        /// add a list specifications of product.
        /// </summary>
        ///  <param name="models"> Enter a list images</param>
        [HttpPost("post list specifications for product")]
        public async Task<IActionResult> AddSpesForProduct(List<ProductSpecifiactionModel> models)
        {
            try
            {
                _uow.CreateTransaction();
                await _uow.Products.AddSpecifications(models);
                await _uow.Save();

                _uow.Commit();

                return Ok();
            }
            catch
            {
                _uow.Rollback();
                return StatusCode(StatusCodes.Status500InternalServerError);

            }

        }
        /// <summary>
        /// Delete all specifications of product, and then add new list specifications of product.
        /// </summary>
        [HttpPut("Update list specifications of product")]
        public async Task<IActionResult> UpdateSpes(List<ProductSpecifiactionModel> models, int idProduct)
        {
            try
            {
                _uow.CreateTransaction();
                await _uow.Products.UpdateSpecifications(models, idProduct);
                await _uow.Save();

                _uow.Commit();

                return Ok();
            }
            catch
            {
                _uow.Rollback();
                return StatusCode(StatusCodes.Status500InternalServerError);

            }

        }

        [HttpDelete("Delete specifications by idSpecifications")]
        public async Task<IActionResult> DeleteSpeByIdSpe(int idSpecifications)
        {
            try
            {
                _uow.CreateTransaction();
                var result = await _uow.Products.DeleteSpeciByIdSpeci(idSpecifications);
                if (result == false)
                {
                    return NotFound("No specification found with id: " + idSpecifications);
                }
                await _uow.Save();

                _uow.Commit();

                return Ok();
            }
            catch
            {
                _uow.Rollback();
                return StatusCode(StatusCodes.Status500InternalServerError);

            }
        }
        /// <summary>
        /// Delete all specifications of product.
        /// </summary>
        [HttpDelete("Delete list specifications of product")]
        public async Task<IActionResult> DeleteAllSpebyIdProduct(int idProduct)
        {
            try
            {
                _uow.CreateTransaction();
                await _uow.Products.DeleteAllSpeciByIdProduct(idProduct);
                await _uow.Save();
                _uow.Commit();

                return Ok();
            }
            catch
            {
                _uow.Rollback();
                return StatusCode(StatusCodes.Status500InternalServerError);

            }
        }
    }
}
