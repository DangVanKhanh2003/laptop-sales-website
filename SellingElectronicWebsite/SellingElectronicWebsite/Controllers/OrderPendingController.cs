﻿using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using SellingElectronicWebsite.Model;
using SellingElectronicWebsite.Sercurity;
using SellingElectronicWebsite.UnitOfWork;
using SellingElectronicWebsite.ViewModel;

namespace SellingElectronicWebsite.Controllers
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
                return Ok(check);
            }
            catch (Exception ex)
            {
                _uow.Rollback();
                return BadRequest(ex.Message);

            }
        }
        /// <summary>
        /// actor: employee=> employee can change status: cancel, approve. Employee cannot change status if status isn't pending.
        /// if status is "approve" and input valid => amount of store will reduce by amount order.
        /// </summary>
        /// <param name="status" > cancel, approve</param>
        /// <param name="idStore">if you want to change status is approve. You need provide idStore.</param>
        /// <returns></returns>
        [HttpPut("ChangeStatusFromEmployee")]
        public async Task<IActionResult> UpdateStatus(string status, int idOrderPending, int idEmployee, int idStore = -1)
        {
            try
            {
                _uow.CreateTransaction();
                var check = await _uow.OrderPendings.UpdateStatus(status, idOrderPending, idEmployee, idStore);
                await _uow.Save();
                _uow.Commit();
                return Ok(check);
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
