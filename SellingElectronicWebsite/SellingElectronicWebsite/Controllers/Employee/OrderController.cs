using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using SellingElectronicWebsite.Entities;
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
        /// Get all order by paging
        /// </summary>
        /// <param name="status">value: "pending"/"cancel"/"approve". Default = "pending"</param>
        /// <param name="sortByOrderDate">value: "timeDesc"/"timeAsc". Default = null</param>

        [HttpGet("GetAllOrder")]
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
        [HttpGet("GetAllOrderPaging")]
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
        [HttpGet("GetAllOrderByIdStorePaging")]
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

        [HttpGet("GetAllOrderByIdStore")]
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

        [HttpPut("ExportOder")]
        public async Task<IActionResult> ExportOder(int idOrder, int employeeId)
        {
            try
            {
                _uow.CreateTransaction();
                var result = await _uow.Orders.ExportOder(idOrder, employeeId);
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
    }
}
