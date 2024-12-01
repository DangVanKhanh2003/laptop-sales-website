using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using SellingElectronicWebsite.Entities;
using SellingElectronicWebsite.Model;
using SellingElectronicWebsite.Sercurity;
using SellingElectronicWebsite.UnitOfWork;

namespace SellingElectronicWebsite.Controllers.Employee
{
    [Route("api/[controller]")]
    [ApiController]
    public class CategoryControler : ControllerBase
    {
        private IUnitOfWork _uow;

        public CategoryControler(IUnitOfWork uow)
        {
            _uow = uow;
        }
        /// <summary>
        /// Get all category
        /// </summary>
        /// <returns></returns>
        [HttpGet]
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
            catch (Exception ex)
            {
                return BadRequest(ex.Message);

            }
        }

        /// <summary>
        /// get category by id
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [HttpGet("{id}")]

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
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }


        /// <summary>
        /// Add Category
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
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
            catch (Exception ex)
            {
                _uow.Rollback();
                return BadRequest(ex.Message);

            }
        }

        /// <summary>
        /// Update category by id 
        /// </summary>
        /// <param name="model"></param>
        /// <param name="id"></param>
        /// <returns></returns>
        [HttpPut("{id}")]
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
            catch (Exception ex)
            {
                _uow.Rollback();

                return BadRequest(ex.Message);

            }
        }
        
        /// <summary>
        /// Delete catory by id
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [HttpDelete("{id}")]
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
            catch (Exception ex)
            {
                return BadRequest(ex.Message);

            }
        }
    }
}
