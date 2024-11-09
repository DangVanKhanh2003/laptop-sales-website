using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using SellingElectronicWebsite.Entities;
using SellingElectronicWebsite.Model;
using SellingElectronicWebsite.Sercurity;
using SellingElectronicWebsite.UnitOfWork;

namespace SellingElectronicWebsite.Controllers.Employee
{
    [Route("api/employee/[controller]")]
    [ApiController]
    public class CategoryControler : ControllerBase
    {
        private IUnitOfWork _uow;

        public CategoryControler(IUnitOfWork uow)
        {
            _uow = uow;
        }

        [HttpGet("getAllCategory")]
        [CustomAuthorizeCustomer("customer")]

        public async Task<IActionResult> GetAll()
        {
            try
            {
                var data = await _uow.Categories.GetAll();
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


        [HttpGet("{id}")]
        [CustomAuthorizeCustomer("customer")]

        public async Task<IActionResult> GetById(int id)
        {
            try
            {
                var data = await _uow.Categories.GetById(id);
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

        
       
        [HttpPost]
        public async Task<IActionResult> Add(CategoryModel model)
        {
            try
            {
                _uow.CreateTransaction();
                var checkName = await _uow.Categories.GetByName(model.CategoryName);

                if (checkName != null)
                {
                    return BadRequest("The category name already exists.");
                }

                var result = await _uow.Categories.Add(model);

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

        [HttpPut]
        public async Task<IActionResult> Update(CategoryModel model, int id)
        {
            try
            {
                _uow.CreateTransaction();

                var checkName = await _uow.Categories.GetByName(model.CategoryName);

                if (checkName != null && id != checkName.CategoryId)
                {
                    return BadRequest("The category name already exists.");
                }


                var result = await _uow.Categories.Update(model, id);

                if (result == false)
                {
                    _uow.Rollback();

                    return NotFound("Not found category with id: " + id);
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
        

        [HttpDelete]
        public async Task<IActionResult> Delete(int id)
        {
            try
            {
                _uow.CreateTransaction();

                var result = await _uow.Categories.Delete(id);
                if (result == false)
                {
                    _uow.Rollback();

                    return NotFound("Not found category with id: " + id);
                }
                await _uow.Save();
                _uow.Commit();
                return Ok(result);
            }
            catch
            {
                return StatusCode(StatusCodes.Status500InternalServerError);

            }
        }
    }
}
