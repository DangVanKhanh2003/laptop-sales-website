using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using SellingElectronicWebsite.Entities;
using SellingElectronicWebsite.Model;
using SellingElectronicWebsite.Sercurity;
using SellingElectronicWebsite.UnitOfWork;
using SellingElectronicWebsite.ViewModel;

namespace SellingElectronicWebsite.Controllers.Employee
{
    [Route("api/[controller]")]
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
        [HttpGet]
        [CustomAuthorizeCustomer("customer")]

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
        [CustomAuthorizeCustomer("customer")]

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
        [HttpPost]
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
                AddressModel addressModel = model.Address;
                var address = await _uow.Addresses.Add(model.Address);
                await _uow.Save();
                _uow.Commit();
                _uow.CreateTransaction();
                var newStore = new Store() { StoreName = model.StoreName, AddressId = address.AddressId };
                var result = await _uow.Store.AddStore(newStore);

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
        [HttpPut("{id}")]
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
        [HttpDelete("{id}")]
        public async Task<IActionResult> Delete(int id)
        {
            try
            {
                _uow.CreateTransaction();

                var result = await _uow.Store.DeleteStore(id);
                if (result == -1)
                {
                    _uow.Rollback();

                    return NotFound("Not found store with id: " + id);
                }
                await _uow.Save();
                var result2 = await _uow.Addresses.Delete(result);
                await _uow.Save();

                _uow.Commit();
                return Ok(result);
            }
            catch (Exception ex)
            {
                _uow.Rollback();
                return StatusCode(StatusCodes.Status500InternalServerError, ex.ToString());

            }
        }

        /// <summary>
        /// Get all product in store by idStore
        /// </summary>
        /// <param name="idStore"></param>
        /// <returns></returns>
        [HttpGet("{idStore}/Product")]
        public async Task<IActionResult> GetAllProductByIdStore(int idStore)
        {
            try
            {
                var data = await _uow.Store.GetAllProductByIdStore(idStore);
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
        /// get product in store by idProduct and idStore
        /// </summary>
        /// <param name="idStore"></param>
        /// <param name="idProduct"></param>
        /// <returns></returns>
        [HttpGet("{idStore}/Product/{idProduct}")]
        public async Task<IActionResult> GetProductByIdStore(int idStore, int idProduct)
        {
            try
            {
                var data = await _uow.Store.GetProductByIdStore(idStore, idProduct);
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
        /// get all store exist product
        /// </summary>
        /// <param name="idProduct"></param>
        /// <returns></returns>
        [HttpGet("{idProduct}/exist-in-store")]

        public async Task<IActionResult> GetStoreExistProduct(int idProduct)
        {
            try
            {
                var data = await _uow.Store.GetStoreExistProduct(idProduct);
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
        /// Add product in store by idStore, idColor and idProduct.
        /// if item exist => add. if item don't exist => create new item.
        /// </summary>
        /// <param name="idProduct"></param>
        /// <param name="idStore"></param>
        /// <param name="amountAdd"></param>
        /// <param name="idColor"></param>
        /// <returns></returns>
        [HttpPut("{idStore}/Product/{idProduct}/Color/{idColor}/add-new-product")]
        public async Task<IActionResult> AddStoreProduct(int idProduct, int idStore, int amountAdd, int idColor)
        {
            try
            {
                _uow.CreateTransaction();

                var result = await _uow.Store.AddStoreProduct(idProduct, idStore, amountAdd, idColor);
                await _uow.Save();
                _uow.Commit();
                return Ok(result);
            }
            catch (Exception ex)
            {
                _uow.Rollback();
                return StatusCode(StatusCodes.Status500InternalServerError, ex.Message);

            }
        }

        /// <summary>
        /// Reduce product in store by idStore, idColor and idProduct
        /// </summary>
        /// <param name="idProduct"></param>
        /// <param name="idStore"></param>
        /// <param name="amountReduce"></param>
        /// <param name="idColor"></param>
        /// <returns></returns>
        [HttpPut(("{idStore}/Product/{idProduct}/Color/{idColor}/reduce-new-product"))]
        public async Task<IActionResult> ReduceStoreProduct(int idProduct, int idStore, int amountReduce, int idColor)
        {
            try
            {
                _uow.CreateTransaction();

                var result = await _uow.Store.ReduceStoreProduct(idProduct, idStore, amountReduce, idColor);
                await _uow.Save();

                _uow.Commit();
                return Ok(result);
            }
            catch (Exception ex)
            {
                _uow.Rollback();
                return StatusCode(StatusCodes.Status500InternalServerError, ex.Message);

            }
        }


        /// <summary>
        /// Update amount of product by idStore, idProduct and idColor
        /// </summary>
        /// <param name="idProduct"></param>
        /// <param name="idStore"></param>
        /// <param name="amount"></param>
        /// <param name="idColor"></param>
        /// <returns></returns>
        [HttpPut(("{idStore}/Product/{idProduct}/Color/{idColor}/update-amount-product"))]
        public async Task<IActionResult> UpdateAmountStoreProduct(int idProduct, int idStore, int amount, int idColor)
        {
            try
            {
                _uow.CreateTransaction();

                var result = await _uow.Store.UpdateAmountStoreProduct(idProduct, idStore, amount, idColor);
                await _uow.Save();

                _uow.Commit();
                return Ok(result);
            }
            catch (Exception ex)
            {
                _uow.Rollback();
                return StatusCode(StatusCodes.Status500InternalServerError, ex.Message);

            }
        }

    }
}
