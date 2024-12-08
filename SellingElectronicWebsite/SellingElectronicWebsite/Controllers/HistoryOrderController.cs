using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using SellingElectronicWebsite.UnitOfWork;
using SellingElectronicWebsite.ViewModel;

namespace SellingElectronicWebsite.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class HistoryOrderController : ControllerBase
    {
        private IUnitOfWork _uow;

        public HistoryOrderController(IUnitOfWork uow)
        {
            _uow = uow;
        }

        /// <summary>
        /// Get all success order by id customer
        /// </summary>
        /// <param name="sortByOrderDate">value: "timeDesc"/"timeAsc". Default = null</param>
        [HttpGet("SuccessOrder")]
        public async Task<IActionResult> GetAllSuccessOrderByIdCustomer(int idCustomer, string sortByOrderDate = null)
        {
            try
            {
                var result = await _uow.Histories.GetAllSuccessOrderByIdCustomer(idCustomer, sortByOrderDate);
                return Ok(result);
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);

            }
        }

        /// <summary>
        /// Get all cancel order by id customer
        /// </summary>
        /// <param name="sortByOrderDate">value: "timeDesc"/"timeAsc". Default = null</param>
        [HttpGet("CancelOrder")]
        public async Task<IActionResult> GetAllCancelOrderByIdCustomer(int idCustomer, string sortByOrderDate = null)
        {
            try
            {
                var result = await _uow.Histories.GetAllCancelOrderByIdCustomer(idCustomer, sortByOrderDate);
                return Ok(result);
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);

            }
        }
    }
}
