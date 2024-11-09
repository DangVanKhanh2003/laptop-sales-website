using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using SellingElectronicWebsite.Entities;
using SellingElectronicWebsite.Model;
using SellingElectronicWebsite.Sercurity;
using SellingElectronicWebsite.UnitOfWork;
using SellingElectronicWebsite.ViewModel;

namespace SellingElectronicWebsite.Controllers.Customer
{
    [Route("api/[controller]")]
    [ApiController]
    [CustomAuthorizeCustomer("customer")]

    public class AddressBookController : ControllerBase
    {
        private IUnitOfWork _uow;

        public AddressBookController(IUnitOfWork uow)
        {
            _uow = uow;
        }

        //Task<List<AddressBookVM>> GetByPage(int pageIndex, int pageSize);
        //Task<List<AddressBookVM>> GetAllByIdCustomer(int id);
        //Task<AddressBookVM> GetByIdAddressBook(int id);
        //Task<bool> Add(AddressBookModel model);
        //Task<bool> Update(AddressBookModel model, int idAddressbook);
        //Task<bool> Delete(int id);

        [HttpGet("GetByPage")]
        public async Task<IActionResult> GetByPage(int pageIndex, int pageSize)
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

        [HttpGet("GetByIdAddressBook{idAddress}")]
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

        [HttpGet("GetAllByIdCustomer{idCustomer}")]
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

        [HttpGet("GetCountAddress")]
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

        [HttpPost]
        public async Task<IActionResult> Add(AddressBookModel model)
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

        [HttpPut]
        public async Task<IActionResult> Update(AddressBookModel model, int idAddressbook)
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

        [HttpDelete]
        public async Task<IActionResult> Delete(int idCustomer)
        {
            try
            {
                _uow.CreateTransaction();
                await _uow.AddressBook.Delete(idCustomer);
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
