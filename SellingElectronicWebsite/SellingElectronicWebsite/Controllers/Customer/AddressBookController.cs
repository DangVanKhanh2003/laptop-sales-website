using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using SellingElectronicWebsite.Entities;
using SellingElectronicWebsite.Model;
using SellingElectronicWebsite.Sercurity;
using SellingElectronicWebsite.UnitOfWork;
using SellingElectronicWebsite.ViewModel;
using System.Net;

namespace SellingElectronicWebsite.Controllers.Customer
{
    [Route("api/[controller]")]
    [ApiController]

    public class AddressBookController : ControllerBase
    {
        private IUnitOfWork _uow;

        public AddressBookController(IUnitOfWork uow)
        {
            _uow = uow;
        }

        /// <summary>
        /// get all address by page
        /// </summary>
        /// <param name="pageIndex">default = 1</param>
        /// <param name="pageSize"> default = 10</param>
        /// <returns></returns>
        [HttpGet]
        public async Task<IActionResult> GetByPage([FromQuery] int pageIndex= 1 , [FromQuery] int pageSize = 10)
        {
            try
            {
                var addressbooks = await _uow.AddressBook.GetByPage(pageIndex, pageSize);
                return Ok(addressbooks);
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);

            }
        }

        /// <summary>
        /// get address by id address
        /// </summary>
        /// <param name="idAddress"></param>
        /// <returns></returns>
        [HttpGet("{idAddress}")]
        public async Task<IActionResult> GetByIdAddressBook(int idAddress)
        {
            try
            {
                var addressbooks = await _uow.AddressBook.GetByIdAddressBook(idAddress);
                return Ok(addressbooks);
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);

            }
        }

        /// <summary>
        /// get all address by id customer
        /// </summary>
        /// <param name="idCustomer"></param>
        /// <returns></returns>
        [HttpGet("Customer/{idCustomer}")]
        public async Task<IActionResult> GetAllByIdCustomer(int idCustomer)
        {
            try
            {
                var addressbooks = await _uow.AddressBook.GetAllByIdCustomer(idCustomer);
                return Ok(addressbooks);
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);

            }
        }

        /// <summary>
        /// Count address
        /// </summary>
        /// <returns>Return amount address</returns>
        [HttpGet("Count-Address")]
        public async Task<IActionResult> GetCountAddress()
        {
            try
            {
                var count = await _uow.AddressBook.GetCountAddress();
                return Ok(count);
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);

            }
        }

        /// <summary>
        /// Add new address in address book of customer
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        [HttpPost]
        public async Task<IActionResult> Add([FromBody] AddressBookModel model)
        {
            try
            {
                _uow.CreateTransaction();
                await _uow.AddressBook.Add(model);
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

        /// <summary>
        /// Change infor address book by idAddressBook
        /// </summary>
        /// <param name="model"></param>
        /// <param name="idAddressbook"></param>
        /// <returns></returns>
        [HttpPut]
        public async Task<IActionResult> Update([FromBody] AddressBookModel model, [FromQuery] int idAddressbook)
        {
            try
            {
                _uow.CreateTransaction();
                await _uow.AddressBook.Update(model, idAddressbook);
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

        /// <summary>
        /// Delete address by id
        /// </summary>
        /// <param name="idAddress"></param>
        /// <returns></returns>
        [HttpDelete("{idAddress}")]
        public async Task<IActionResult> Delete(int idAddress)
        {
            try
            {
                _uow.CreateTransaction();
                await _uow.AddressBook.Delete(idAddress);
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
