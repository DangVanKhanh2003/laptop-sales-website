using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using SellingElectronicWebsite.Model;
using SellingElectronicWebsite.Sercurity;
using SellingElectronicWebsite.UnitOfWork;
using SellingElectronicWebsite.ViewModel;

namespace SellingElectronicWebsite.Controllers.Customer
{
    [Route("api/[controller]")]
    [ApiController]
    [CustomAuthorizeCustomer("customer")]

    public class OrderPendingController : ControllerBase
    {
        private IUnitOfWork _uow;

        public OrderPendingController(IUnitOfWork uow)
        {
            _uow = uow;
        }


        /// <summary>
        /// get all order pending by status and sort by time
        /// </summary>
        /// <param name="status">cancel/pending/approve</param>
        /// <param name="sortBy">timeAsc/timeDesc/null</param>
        [HttpGet("GetAll")]
        public async Task<IActionResult> GetAll(string status = "pending", string sortBy = null)
        {

            try
            {
                var listOrderPending = await _uow.OrderPendings.GetAll(status, sortBy);
                return Ok(listOrderPending);
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);

            }
        }
        /// <param name="status">cancel/pending/approve</param>
        /// <param name="sortBy">timeAsc/timeDesc/null</param>
        [HttpGet("GetByPage")]
        public async Task<IActionResult> GetByPage(string status = "pending", int pageIndex = 1,
            int pageSize = 10, string sortBy = null)
        {

            try
            {
                var listOrderPending = await _uow.OrderPendings.GetByPage(status, pageIndex, pageSize, sortBy);
                return Ok(listOrderPending);
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);

            }
        }

        [HttpGet("GetByIdOrderPending")]
        public async Task<IActionResult> GetByIdOrderPending(int idOrderPending)
        {

            try
            {
                var item = await _uow.OrderPendings.GetById(idOrderPending);
                return Ok(item);
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);

            }
        }



        [HttpPost]
        public async Task<IActionResult> Add(OrderPendingModel model)
        {
            try
            {
                _uow.CreateTransaction();
                var check = await _uow.OrderPendings.Add(model);
                await _uow.Save();
                _uow.Commit();
                return Ok();
            }
            catch (Exception ex)
            {
                _uow.Rollback();
                return BadRequest(ex.Message);

            }
        }

        [HttpPut("ChangeStatusFromEmployee")]
        public async Task<IActionResult> UpdateStatus(string status, int idOrderPending, int idEmployee)
        {
            try
            {
                _uow.CreateTransaction();
                var check = await _uow.OrderPendings.UpdateStatus(status, idOrderPending, idEmployee);
                await _uow.Save();
                _uow.Commit();
                return Ok();
            }
            catch (Exception ex)
            {
                _uow.Rollback();
                return BadRequest(ex.Message);

            }
        }

        [HttpPut("cancelFromCustomer")]
        public async Task<IActionResult> Cancel(int idOrderPending)
        {
            try
            {
                _uow.CreateTransaction();
                var check = await _uow.OrderPendings.Cancel(idOrderPending);
                await _uow.Save();
                _uow.Commit();
                return Ok();
            }
            catch (Exception ex)
            {
                _uow.Rollback();
                return BadRequest(ex.Message);

            }
        }
    }
}
