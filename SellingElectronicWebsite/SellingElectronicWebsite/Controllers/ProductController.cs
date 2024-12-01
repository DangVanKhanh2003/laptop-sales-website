using AutoMapper;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using SellingElectronicWebsite.Entities;
using SellingElectronicWebsite.Model;
using SellingElectronicWebsite.Repository;
using SellingElectronicWebsite.ViewModel;
using SellingElectronicWebsite.UnitOfWork;
using Microsoft.AspNetCore.Http.HttpResults;
using Microsoft.Data.SqlClient;
using System.Data;

namespace SellingElectronicWebsite.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ProductController : ControllerBase
    {
        private IUnitOfWork _uow;
        private readonly string _targetFilePath = Path.Combine(Directory.GetCurrentDirectory(), "UploadedImages");


        public ProductController(IUnitOfWork uow)
        {
            _uow = uow;
            if (!Directory.Exists(_targetFilePath))
            {
                Directory.CreateDirectory(_targetFilePath);
            }
        }


        /// <summary>
        /// 
        /// </summary>
        /// <remarks>
        /// {
        ///    "base64Image": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9",
        ///   "fileName": "Iphone14Xanh",
        ///    "extension": ".png"
        ///  }
        /// </remarks>
        /// <param name="request">Extension exemple: .jpg, .png,...</param>
        /// <returns>The requested item, if found.</returns>
        /// <response code="200">Returns the requested item.</response>
        /// <response code="404">If the item is not found.</response>
        [HttpPost("save-image")]
        public async Task<IActionResult> SaveImage([FromBody] SaveImageModel img)
        {

            try
            {
                _uow.CreateTransaction();
                var result = await _uow.Products.SaveImg(img);
                _uow.Save();
                _uow.Commit();
                return Ok(result );
            }
            catch (Exception ex)
            {
                _uow.Rollback();
                return StatusCode(500, $"Internal server error: {ex.Message}");
            }
        } 
        [HttpGet("get-image")]
        public async Task<IActionResult> getImage(int idSaveImg)
        {

            try
            {
                _uow.CreateTransaction();
                var result = await _uow.Products.GetImageByIdSaveImage(idSaveImg);
                _uow.Save();
                _uow.Commit();
                return Ok(result);
            }
            catch (Exception ex)
            {
                _uow.Rollback();
                return StatusCode(500, $"Internal server error: {ex.Message}");
            }
        }

        /// <summary>
        /// List all products.
        /// </summary>
        /// 
        /// <remarks>
        ///  In default, value of sortBy is null.If you want to sort, you can enter value for "sortBy" parameter.
        /// </remarks>
        /// 
        /// <param name="sortBy">sortBy: price_desc/price_asc/name_desc/null(default)</param>
        [HttpGet]
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
        /// List all products by id category.
        /// </summary>
        /// <remarks>
        ///  In default, value of sortBy is null.If you want to sort, you can enter value for "sortBy" parameter.
        /// </remarks>
        /// 
        /// <param name="sortBy">sortBy: price_desc/price_asc/name_desc/null(default)</param>
        [HttpGet("Category/{idCategory}")]
        public async Task<IActionResult> getAllProductByCategory(int idCategory, string sortBy = null)
        {
            try
            {
                var data = await _uow.Products.GetProductByIdCategory(idCategory, sortBy);
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
        [HttpGet("Count")]
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
        /// Enter pageIndex, pageSize, sortBy.In default, value of sortBy is null.If you want to sort, you can enter value for "sortBy" parameter.

        /// </remarks>
        /// 
        /// <param name="sortBy">sortBy: price_desc/price_asc/name_desc/null(default)</param>

        [HttpGet("Page")]
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
        /// get all colors of product.
        /// </summary>
        [HttpGet("{ProudctId}/Color")]
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

        /// <summary>
        /// Get all specification by productId
        /// </summary>
        /// <param name="ProductId"></param>
        /// <returns></returns>
        [HttpGet("{ProductId}/Specification")]
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

        [HttpGet("{ProductId}/Image")]
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
        /// Search product by nameProduct
        /// </summary>
        /// <param name="nameProduct"></param>
        /// <returns></returns>
        [HttpGet("Search")]
        public async Task<IActionResult> SearchProductByName([FromQuery]string nameProduct = null)
        {
            try
            {
                var products = await _uow.Products.SearchProductByName(nameProduct);

                return Ok(products);
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
                    _uow.Rollback();

                    return BadRequest("The product name already exists.");
                }
                var checkCatagory = await _uow.Products.CategoryExists(model.CategoryId);
                if (checkCatagory == false)
                {
                    _uow.Rollback();

                    return BadRequest("The category id don't already exists.");
                }
                if (model.Price < 0)
                {
                    _uow.Rollback();

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
        /// add a list images of product.
        /// </summary>
        ///  <param name="models"> Enter a list images</param>
        [HttpPost("/Image")]
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
        /// add a list specifications of product.
        /// </summary>
        ///  <param name="models"> Enter a list images</param>
        [HttpPost("/Specification")]
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
        /// Delete all images of product, and then add new list images of product.
        /// </summary>
        [HttpPut("{idProduct}/Image")]
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

        /// <summary>
        /// Delete all specifications of product, and then add new list specifications of product.
        /// </summary>
        /// 
        [HttpPut("{idProduct}/Specification")]
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
        /// <summary>
        /// Update product
        /// </summary>
        /// 
        /// <remarks>
        /// server find prouduct by id(input) and update the product. mainImg used for show image product in the card product of list product(mainImg is link img)
        /// </remarks>

        [HttpPut("{id}")]
        public async Task<IActionResult> Update(ProductModel model, int id)
        {
            try
            {
                _uow.CreateTransaction();

                var checkName = await _uow.Products.GetByName(model.ProductName);

                if (checkName != null && id != checkName.ProductId)
                {
                    _uow.Rollback();

                    return BadRequest("The product name already exists.");
                }

                var checkCatagory = await _uow.Products.CategoryExists(model.CategoryId);
                if (checkCatagory == false)
                {
                    _uow.Rollback();

                    return BadRequest("The category id don't already exists.");
                }

                if (model.Price < 0)
                {
                    _uow.Rollback();

                    return BadRequest("The price invalid.");

                }

                var result = await _uow.Products.Update(model, id);

                if (result == false)
                {
                    _uow.Rollback();

                    return NotFound("Not found product with id: " + id);
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
        [HttpDelete("{id}")]
        public async Task<IActionResult> Delete(int id)
        {
            try
            {
                _uow.CreateTransaction();

                var result = await _uow.Products.Delete(id);
                if (result == false)
                {
                    _uow.Rollback();

                    return NotFound("Not found product with id: " + id);
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
        /// Delete all images of product.
        /// </summary>
        [HttpDelete("{idProduct}/Image")]
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


        /// <summary>
        /// Delete Image by idImg
        /// </summary>
        /// <param name="idImg"></param>
        /// <returns></returns>
        [HttpDelete("/Image/{idImg}")]
        public async Task<IActionResult> DeleteImgByIdImg(int idImg)
        {
            try
            {
                _uow.CreateTransaction();
                var result = await _uow.Products.DeleteImgByIdImg(idImg);
                if (result == false)
                {
                    _uow.Rollback();

                    return NotFound("Not found image with id: " + idImg);
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
        /// Delete Specification by idSpecification
        /// </summary>
        /// <param name="idSpecifications"></param>
        /// <returns></returns>
        [HttpDelete("/Specification/{idSpecifications}")]
        public async Task<IActionResult> DeleteSpeByIdSpe(int idSpecifications)
        {
            try
            {
                _uow.CreateTransaction();
                var result = await _uow.Products.DeleteSpeciByIdSpeci(idSpecifications);
                if (result == false)
                {
                    _uow.Rollback();

                    return NotFound("Not found specification with id: " + idSpecifications);
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
        [HttpDelete("{idProduct}/Specification")]
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
