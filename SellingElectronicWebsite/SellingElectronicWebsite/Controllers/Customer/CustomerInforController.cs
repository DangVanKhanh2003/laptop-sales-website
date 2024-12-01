using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using SellingElectronicWebsite.Entities;
using SellingElectronicWebsite.Model;
using SellingElectronicWebsite.Sercurity;
using SellingElectronicWebsite.UnitOfWork;
using SellingElectronicWebsite.ViewModel;

namespace SellingElectronicWebsite.Controllers.Customer
{
    [Route("api/[controller]")]
    [ApiController]

    public class CustomerInforController : ControllerBase
    {
        private IUnitOfWork _uow;

        public CustomerInforController(IUnitOfWork uow)
        {
            _uow = uow;
        }


        /// <summary>
        /// get all customer infor
        /// </summary>
        /// <param name="sortBy">defaul is null. you can fill:name_asc(sort ascending by name)/  name_desc(sort descending by name)</param>
        [HttpGet]
        public async Task<IActionResult> GetAll(string sortBy= null)
        {
            try
            {
                var customers = await _uow.Customers.GetAll(sortBy);
                return Ok(customers);
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }

        /// <summary>
        /// get all customer infor by page
        /// </summary>
        /// <param name="sortBy">defaul is null. you can fill:name_asc(sort ascending by name)/  name_desc(sort descending by name)</param>
        /// <returns></returns>
        [HttpGet("page")]
        public async Task<IActionResult> getByPage(int pageIndex, int pageSize, string sortBy=null)
        {
            try
            {
                var listAccount = await _uow.Customers.GetByPage(pageIndex, pageSize, sortBy);
                return Ok(listAccount);
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);

            }
        }
        [HttpGet("{idCustomer}")]
        public async Task<IActionResult> GetByIdCustomer(int idCustomer)
        {
            try
            {
                var acc = await _uow.Customers.GetById(idCustomer);

                return Ok(acc);
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);

            }
        }
        /// <summary>
        /// add success => infor new customer
        /// </summary>
        [HttpPost]
        public async Task<IActionResult> addNewCustomer(CustomerModel model)
        {
            try
            {
                _uow.CreateTransaction();
                var customer = await _uow.Customers.Add(model);
                await _uow.Save();
                _uow.Commit();
                return Ok(customer);
            }
            catch (Exception ex)
            {
                _uow.Rollback();

                return BadRequest(ex.Message);
            }
        }

        /// <summary>
        /// update customer by id
        /// </summary>
        /// <param name="model"></param>
        /// <param name="idCustomer"></param>
        /// <returns></returns>
        [HttpPut("{idCustomer}")]
        public async Task<IActionResult> updateInfoCustomer(CustomerModel model, int idCustomer)
        {
            try
            {
                _uow.CreateTransaction();

                var check = await _uow.Customers.Update(model, idCustomer);
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
        /// not complete
        /// </summary>
        [HttpDelete("{idCustomer}")]
        public async Task<IActionResult> deleteCustomerById(int id)
        {
            return null;
        }
    }
}
