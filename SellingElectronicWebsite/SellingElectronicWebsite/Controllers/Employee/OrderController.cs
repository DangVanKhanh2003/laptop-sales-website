using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using SellingElectronicWebsite.Entities;
using SellingElectronicWebsite.Model;
using SellingElectronicWebsite.UnitOfWork;
using SellingElectronicWebsite.ViewModel;
using System.Drawing.Printing;
using System.Net.NetworkInformation;

namespace SellingElectronicWebsite.Controllers.Employee
{
    [Route("api/[controller]")]
    [ApiController]
    public class OrderController : ControllerBase
    {
        private IUnitOfWork _uow;

        public OrderController(IUnitOfWork uow)
        {
            _uow = uow;
        }
        /// <summary>
        /// Get all order 
        /// </summary>
        /// <param name="status">value: "pending"/"cancel"/"approve". Default = "pending"</param>
        /// <param name="sortByOrderDate">value: "timeDesc"/"timeAsc". Default = null</param>

        [HttpGet]
        public async Task<IActionResult> GetAll(string status = "pending", string sortByOrderDate = null)
        {
            try
            {
                var result = await _uow.Orders.GetAll(status, sortByOrderDate);
                return Ok(result); 
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }
        /// <summary>
        /// Get all order by paging
        /// </summary>
        /// <param name="status">value: "pending"/"cancel"/"approve". Default = "pending"</param>
        /// <param name="sortByOrderDate">value: "timeDesc"/"timeAsc". Default = null</param>
        /// <param name="pageIndex">default = 1</param>
        /// <param name="pageSize">default = 10</param>
        [HttpGet("page")]
        public async Task<IActionResult> GetAllPaging(string status = "pending", string sortByOrderDate = null, int pageIndex = 1, int pageSize= 10)
        {
            try
            {
                var result = await _uow.Orders.GetAllPaging(status, sortByOrderDate, pageIndex, pageSize);
                return Ok(result);
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }
        /// <summary>
        /// Get all order by paging
        /// </summary>
        /// <param name="status">value: "pending"/"cancel"/"approve". Default = "pending"</param>
        /// <param name="sortByOrderDate">value: "timeDesc"/"timeAsc". Default = null</param>
        /// <param name="pageIndex">default = 1</param>
        /// <param name="pageSize">default = 10</param>
        [HttpGet("store/{idStore}/page")]
        public async Task<IActionResult> GetByIdStorePaging( int idStore, string status = "pending", 
            string sortByOrderDate = null, int pageIndex = 1, int pageSize = 10)
        {
            try
            {
                var result = await _uow.Orders.GetByIdStorePaging(status, sortByOrderDate, idStore, pageIndex, pageSize);
                return Ok(result);
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }
        /// <summary>
        /// Get all order by paging
        /// </summary>
        /// <param name="status">value: "pending"/"cancel"/"approve". Default = "pending"</param>
        /// <param name="sortByOrderDate">value: "timeDesc"/"timeAsc". Default = null</param>

        [HttpGet("store/{idStore}")]
        public async Task<IActionResult> GetByIdStore(int idStore,string status = "pending", string sortByOrderDate = null)
        {
            try
            {
                var result = await _uow.Orders.GetByIdStore(status, sortByOrderDate, idStore);
                return Ok(result);
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }

        /// <summary>
        /// Get all order by id customer
        /// </summary>
        /// <param name="status">value: "pending"/"cancel"/"approve". Default = "pending"</param>

        [HttpGet("customer/{idCustomer}")]
        public async Task<IActionResult> GetByIdCustomer(int idCustomer, string status = "pending")
        {
            try
            {
                var result = await _uow.Orders.GetByIdCustomer(idCustomer, status);
                return Ok(result);
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }


        /// <summary>
        /// Export order
        /// </summary>
        /// <param name="idOrder"></param>
        /// <param name="employeeId"></param>
        /// <returns></returns>
        [HttpPut("Export")]
        public async Task<IActionResult> ExportOrder(int idOrder, int employeeId)
        {
            try
            {
                _uow.CreateTransaction();
                var result = await _uow.Orders.ExportOrder(idOrder, employeeId);
                await _uow.Save();
                _uow.Commit();
                return Ok(result);
            }
            catch(Exception ex)
            {
                _uow.Rollback();
                return BadRequest(ex.Message);
            }
        }

        /// <summary>
        /// Cancel order
        /// </summary>
        /// <param name="idOrder"></param>
        /// <param name="employeeId"></param>
        /// <returns></returns>
        [HttpPut("Cancel")]
        public async Task<IActionResult> CancelOrder(int idOrder, int employeeId)
        {
            try
            {
                _uow.CreateTransaction();
                var result = await _uow.Orders.CancelOrder(idOrder, employeeId);
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
        /// Create order offline. Used for employee create order at store.
        /// </summary>
        /// <param name="model">CustomerId can be null</param>
        /// <returns>order View Model</returns>
        [HttpPut("Oder-offline")]
        public async Task<IActionResult> OderOffline(OrderOfflineModel model)
        {
            try
            {
                _uow.CreateTransaction();
                var result = await _uow.Orders.OderOffline(model);
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
