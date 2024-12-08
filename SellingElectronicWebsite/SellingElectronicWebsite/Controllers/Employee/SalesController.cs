using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Http.HttpResults;
using Microsoft.AspNetCore.Mvc;
using SellingElectronicWebsite.Entities;
using SellingElectronicWebsite.Model;
using SellingElectronicWebsite.UnitOfWork;
using SellingElectronicWebsite.ViewModel;

namespace SellingElectronicWebsite.Controllers.Employee
{
    [Route("api/[controller]")]
    [ApiController]
    public class SalesController : ControllerBase
    {

        private IUnitOfWork _uow;

        public SalesController(IUnitOfWork uow)
        {
            _uow = uow;
        }

        /// <summary>
        /// get all sales
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public async Task<IActionResult> GetAll()
        {
            try
            {
                var data = await _uow.Sales.GetAll();
                if (data == null)
                {
                    return NotFound();
                }
                return Ok(data); // Return the data in the response
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }

        /// <summary>
        /// get sale by id 
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [HttpGet("{id}")]
        public async Task<IActionResult> GetById(int id)
        {
            try
            {
                var data = await _uow.Sales.GetById(id);
                if (data == null)
                {
                    return NotFound();
                }
                return Ok(data);
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }

        /// <summary>
        /// Get all sale by id product
        /// </summary>
        [HttpGet("Product/{idProduct}")]
        public async Task<IActionResult> GetByIdProduct(int idProduct)
        {
            try
            {

                var checkProductExist = await _uow.Sales.checkProductExist(idProduct);
                if(checkProductExist == null)
                {
                    return NotFound("Not found product by id: " + idProduct);
                }    
                var data = await _uow.Sales.GetByIdProduct(idProduct);
                if (data == null)
                {
                    return NotFound();
                }
                return Ok(data);
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }

        /// <summary>
        /// add new sale
        /// </summary>
        /// <param name="model">"numProduct = null" is not limited number products sale</param>
        /// <returns></returns>
        [HttpPost]
        public async Task<IActionResult> Add(SalesModel model)
        {
            try
            {
                _uow.CreateTransaction();
                var checkProductExist = await _uow.Sales.checkProductExist(model.ProductId);
                if (checkProductExist == false)
                {
                    _uow.Rollback();
                    return NotFound("Not found product by id: " + model.ProductId);
                }

                var result = await _uow.Sales.Add(model);
                if(result == false)
                {
                    _uow.Rollback();
                    return BadRequest("Time is conflict!");
                }
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
        /// update sale by id
        /// </summary>
        /// <param name="model">"numProduct = null" is not limited number products sale</param>
        /// <returns></returns>

        [HttpPut("{id}")]
        public async Task<IActionResult> Update(SalesModel model, int id)
        {
            try
            {
                _uow.CreateTransaction();
                var checkProductExist = await _uow.Sales.checkProductExist(model.ProductId);
                if (checkProductExist == false)
                {
                    _uow.Rollback();
                    return NotFound("Not found product by id: " + id);
                }
                var checkSaleExist = await _uow.Sales.GetById(id);
                if (checkSaleExist == null)
                {
                    _uow.Rollback();
                    return NotFound("Not found sale by id: " + id);
                }
                var result = await _uow.Sales.Update(model, id);
                if (result == false)
                {
                    _uow.Rollback();
                    return BadRequest("Time is conflict!");

                }
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
        /// delete sale by id
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [HttpDelete("{id}")]
        public async Task<IActionResult> Delete(int id)
        {
            try
            {
                _uow.CreateTransaction();

                var result = await _uow.Sales.Delete(id);
                if (result == false)
                {
                    _uow.Rollback();
                    return NotFound("Not found sale with id: " + id);
                }
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
        /// Delete all sales of product by idProduct
        /// </summary>
        [HttpDelete("Product/{idProduct}")]
        public async Task<IActionResult> DeleteByIdProduct(int idProduct)
        {
            try
            {
                _uow.CreateTransaction();
                var checkProductExist = await _uow.Sales.checkProductExist(idProduct);
                if (checkProductExist == false)
                {
                    _uow.Rollback();
                    return NotFound("Not found product by id: " + idProduct);
                }
                var result = await _uow.Sales.DeleteByIdProduct(idProduct);
                if (result == false)
                {
                    _uow.Rollback();
                    return NotFound("Not found sale with product id: " + idProduct);
                }
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
