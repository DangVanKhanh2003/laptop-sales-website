﻿using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using SellingElectronicWebsite.Model;
using SellingElectronicWebsite.UnitOfWork;

namespace SellingElectronicWebsite.Controllers.Employee
{
    [Route("api/employee/[controller]")]
    [ApiController]
    public class StoreController : ControllerBase
    {
        private IUnitOfWork _uow;

        public StoreController(IUnitOfWork uow)
        {
            _uow = uow;
        }

        /// <summary>
        /// List all Stores.
        /// </summary>

        [HttpGet("getAllStore")]
        public async Task<IActionResult> GetAllStore()
        {
            try
            {
                var data = await _uow.Store.GetAllStore();
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
        /// Get stores by id.
        /// </summary>

        [HttpGet("{idStore}")]
        public async Task<IActionResult> GetStoreById(int idStore)
        {
            try
            {
                var data = await _uow.Store.GetStoreById(idStore);
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
        /// Add new store. 
        /// </summary>

        [HttpPost("AddStore")]
        public async Task<IActionResult> AddStore(StoreModel model)
        {
            try
            {
                _uow.CreateTransaction();
                var checkName = await _uow.Store.GetStoreByName(model.StoreName);

                if (checkName != null)
                {
                    _uow.Rollback();

                    return BadRequest("The store name already exists.");
                }

                var result = await _uow.Store.AddStore(model);

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
        /// Update store
        /// </summary>
        /// 
        /// <remarks>
        /// server find store by id(input) and update the store.
        /// </remarks>

        [HttpPut("UpdateStore")]
        public async Task<IActionResult> Update(StoreModel model, int id)
        {
            try
            {
                _uow.CreateTransaction();

                var checkName = await _uow.Store.GetStoreByName(model.StoreName);

                if (checkName != null && id != checkName.StoreId)
                {
                    _uow.Rollback();

                    return BadRequest("The store name already exists.");
                }


                var result = await _uow.Store.UpdateStore(model, id);

                if (result == false)
                {
                    _uow.Rollback();

                    return NotFound("Not found store with id: " + id);
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
        /// Delete store.
        /// </summary>
        /// 
        /// <remarks>
        /// Server find store and delete.
        /// </remarks>

        [HttpDelete("DeleteStore")]
        public async Task<IActionResult> Delete(int id)
        {
            try
            {
                _uow.CreateTransaction();

                var result = await _uow.Store.DeleteStore(id);
                if (result == false)
                {
                    _uow.Rollback();

                    return NotFound("Not found store with id: " + id);
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
