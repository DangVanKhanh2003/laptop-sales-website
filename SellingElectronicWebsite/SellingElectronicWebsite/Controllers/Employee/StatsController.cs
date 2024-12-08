using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using SellingElectronicWebsite.UnitOfWork;
using SellingElectronicWebsite.ViewModel;

namespace SellingElectronicWebsite.Controllers.Employee
{
    [Route("api/[controller]")]
    [ApiController]
    public class StatsController : ControllerBase
    {
        private IUnitOfWork _uow;

        public StatsController(IUnitOfWork uow)
        {
            _uow = uow;
        }

        [HttpGet]
        public async Task<IActionResult> GetStats(DateOnly startDate, DateOnly endDate, string unit = "date")
        {
            try
            {
                var data = await _uow.Stats.GetStats(startDate, endDate, unit);
               
                return Ok(data); // Return the data in the response
            }
            catch (Exception ex)
            {
                {
                    return BadRequest(ex.Message);
                }
            }
        }
        [HttpGet("Category{categoryId}")]

        public async Task<IActionResult> GetStatsByIdCategory(DateOnly startDate, DateOnly endDate, int categoryId, string unit = "date")
        {

            try
            {
                var data = await _uow.Stats.GetStatsByIdCategory(startDate, endDate, categoryId, unit);
                
                return Ok(data); // Return the data in the response
            }
            catch (Exception ex)
            {
                {
                    return BadRequest(ex.Message);
                }
            }
        }

    }
}
