﻿using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using SellingElectronicWebsite.Entities;
using SellingElectronicWebsite.Model;
using SellingElectronicWebsite.Sercurity;
using SellingElectronicWebsite.UnitOfWork;
using SellingElectronicWebsite.ViewModel;
using static Microsoft.EntityFrameworkCore.DbLoggerCategory;

namespace SellingElectronicWebsite.Controllers.Customer
{
    [Route("api/[controller]")]
    [ApiController]
    [CustomAuthorizeCustomer("customer")]

    public class ShoppingCartController : ControllerBase
    {
        private IUnitOfWork _uow;

        public ShoppingCartController(IUnitOfWork uow)
        {
            _uow = uow;
        }
       
        [HttpGet]
        public async Task<IActionResult> GetByIdCustomer(int idCustomer)
        {
            try
            {
                var items = await _uow.ShoppingCarts.GetByIdCustomer(idCustomer);
                return Ok(items);
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);

            }
        }
        /// <summary>
        /// if exist element(in shopping cart) same idCustomer, idProduct, idColor with this item => 
        /// addition amount to amount of element in this shopping cart. The sale of product automatic addition when shopping cart item add new. 
        /// </summary>
        [HttpPost("AddItemShoppingCart")]
        public async Task<IActionResult> Add(ShoppingCartItemModel model)
        {
            try
            {
                _uow.CreateTransaction();
                var check = await _uow.ShoppingCarts.Add(model);
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
        /// update amount for item in shoppingCart by idShoppingCart
        /// </summary>
        [HttpPut("UpdateAmountForItemShoppingCart")]
        public async Task<IActionResult> Update(int amount, int idShoppingCartItem)
        {
            try
            {
                _uow.CreateTransaction();
                //update amount for item in shoppingCart by idShoppingCart
                var check = await _uow.ShoppingCarts.UpdateAmount(amount, idShoppingCartItem);
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
        [HttpDelete]
        public async Task<IActionResult> Delete(int idShoppingCartItem)
        {
            try
            {
                _uow.CreateTransaction();
                var check = await _uow.ShoppingCarts.Delete(idShoppingCartItem);
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
        [HttpDelete("DeleteAllShoppingCartItemByIdCustomer")]
        public async Task<IActionResult> DeleteAllByIdCustomer(int idCustomer)
        {
            try
            {
                _uow.CreateTransaction();
                var check = await _uow.ShoppingCarts.DeleteAllByIdCustomer(idCustomer);
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
    }
}