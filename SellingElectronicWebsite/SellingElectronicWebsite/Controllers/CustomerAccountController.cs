using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using SellingElectronicWebsite.Model;
using SellingElectronicWebsite.UnitOfWork;
using SellingElectronicWebsite.ViewModel;
using Microsoft.EntityFrameworkCore;
using System.Text.RegularExpressions;
using System.ComponentModel.DataAnnotations;
using Microsoft.Extensions.Configuration;
using SellingElectronicWebsite.Entities;
using SellingElectronicWebsite.Helper;
using System.Text.Json;
using SellingElectronicWebsite.Sercurity;
namespace SellingElectronicWebsite.Controllers

{
    [Route("api/[controller]")]
    [ApiController]

    public class CustomerAccountController : ControllerBase
    {
        private IUnitOfWork _uow;

        public CustomerAccountController(IUnitOfWork uow)
        {
            _uow = uow;
        }

        /// <summary>
        /// Get all account customer
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public async Task<IActionResult> getAllAccount()
        {
            try
            {
                var listAccount = await _uow.CustomersAccount.GetAll();
                return Ok(listAccount);
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);

            }
        }

        /// <summary>
        /// get all account by page
        /// </summary>
        /// <param name="pageIndex"></param>
        /// <param name="pageSize"></param>
        /// <returns></returns>
        [HttpGet("Page")]
        public async Task<IActionResult> getByPage(int pageIndex, int pageSize)
        {
            try
            {
                var listAccount = await _uow.CustomersAccount.GetByPage(pageIndex, pageSize);
                return Ok(listAccount);
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);

            }
        }

        /// <summary>
        /// Get account by idCustomer
        /// </summary>
        /// <param name="idCustomer"></param>
        /// <returns></returns>
        [HttpGet("Customer/{idCustomer}")]
        public async Task<IActionResult> GetByIdCustomer(int idCustomer)
        {
            try
            {
                var acc = await _uow.CustomersAccount.GetByIdCustomer(idCustomer);
                return Ok(acc);
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);

            }
        }
        /// <summary>
        /// if login success => token(access vs refresh).
        /// </summary>

        [HttpGet("Login")]
        public async Task<IActionResult> CheckLogin(string email, string password)
        {
            try
            {

                var check = await _uow.CustomersAccount.CheckLogin(email, password);
                return Ok(check);
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);

            }
        }
        /// <summary>
        /// Create new user with new account
        /// </summary>
        [HttpPost("RegisterAccount")]
        public async Task<IActionResult> Register(string email, string password)
        {
            Entities.Customer newCustomer;
            try
            {
                _uow.CreateTransaction();
                if (string.IsNullOrWhiteSpace(email))
                {
                    throw new Exception("Email: '" + email + "' is invalid");

                }

                var emailRegex = new Regex(@"^[a-z][a-z|0-9|]*([_][a-z|0-9]+)*([.][a-z|0-9]+([_][a-z|0-9]+)*)?@[a-z][a-z|0-9|]*\.([a-z][a-z|0-9]*(\.[a-z][a-z|0-9]*)?)$", RegexOptions.IgnoreCase);
                var checkEmailValid = emailRegex.IsMatch(email);
                if (checkEmailValid == false)
                {
                    throw new Exception("Email: '" + email + "' is invalid");
                }
                var checkEmail = await _uow.CustomersAccount.checkEmailExist(email);
                if (checkEmail)
                {
                    return BadRequest("Email: " + email + " is already exist!");
                }
                newCustomer = await _uow.Customers.AddEmpty();
                await _uow.Save();


                if (newCustomer != null)
                {
                    CustomerAccountModel acc = new CustomerAccountModel(newCustomer.CustomerId, password, email);

                    var check = await _uow.CustomersAccount.Register(acc);
                    await _uow.Save();
                    _uow.Commit();
                    return Ok(check);
                }
                _uow.Rollback();
                return Ok("Error");
            }
            catch (Exception ex)
            {

                _uow.Rollback();
                return BadRequest(ex.Message);

            }
        }

        /// <summary>
        /// Change Pasword
        /// </summary>
        /// <param name="email"></param>
        /// <param name="password"></param>
        /// <param name="newPassword"></param>
        /// <returns></returns>
        [HttpPut]
        [CustomAuthorizeCustomer("customer")]

        public async Task<IActionResult> ChangePassword(string email, string password, string newPassword)
        {
            try
            {
                _uow.CreateTransaction();
                var check = await _uow.CustomersAccount.ChangePassword(email, password, newPassword);
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
        /// not code yet
        /// </summary>
        [HttpDelete]
        public async Task<IActionResult> DeleteAccountByIdCustomer(int id)
        {
            try
            {

                return Ok("unfinished");
            }
            catch (Exception ex)
            {
                _uow.Rollback();
                return BadRequest(ex.Message);

            }
        }
    }
}
