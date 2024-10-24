using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using SellingElectronicWebsite.Model;
using SellingElectronicWebsite.UnitOfWork;

namespace SellingElectronicWebsite.Controllers.Employee
{
    [Route("api/employee/[controller]")]
    [ApiController]
    public class ColorController : ControllerBase
    {

        private IUnitOfWork _uow;

        public ColorController(IUnitOfWork uow)
        {
            _uow = uow;
        }
        /// <summary>
        /// List all colors. Color used for chossing color of color image
        /// </summary>

        [HttpGet("getAllColor")]
        public async Task<IActionResult> GetAll()
        {
            try
            {
                var data = await _uow.Colors.GetAll();
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
        /// Get colors by id.
        /// </summary>

        [HttpGet("{id}")]
        public async Task<IActionResult> GetById(int id)
        {
            try
            {
                var data = await _uow.Colors.GetById(id);
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
        /// Add new color. 
        /// </summary>

        [HttpPost]
        public async Task<IActionResult> Add(ColorModel model)
        {
            try
            {
                _uow.CreateTransaction();
                var checkName = await _uow.Colors.GetByName(model.ColorName);

                if (checkName != null)
                {
                    return BadRequest("The color name already exists.");
                }
             
                var result = await _uow.Colors.Add(model);

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
        /// Update color
        /// </summary>
        /// 
        /// <remarks>
        /// server find color by id(input) and update the color.
        /// </remarks>

        [HttpPut]
        public async Task<IActionResult> Update(ColorModel model, int id)
        {
            try
            {
                _uow.CreateTransaction();

                var checkName = await _uow.Colors.GetByName(model.ColorName);

                if (checkName != null && id != checkName.ColorId)
                {
                    return BadRequest("The color name already exists.");
                }


                var result = await _uow.Colors.Update(model, id);

                if (result == false)
                {
                    _uow.Rollback();

                    return NotFound("Not found color with id: " + id);
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
        /// Delete color.
        /// </summary>
        /// 
        /// <remarks>
        /// Server find color and delete.
        /// </remarks>

        [HttpDelete]
        public async Task<IActionResult> Delete(int id)
        {
            try
            {
                _uow.CreateTransaction();

                var result = await _uow.Colors.Delete(id);
                if (result == false)
                {
                    _uow.Rollback();

                    return NotFound("Not found color with id: " + id);
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

    }
}
