using SellingElectronicWebsite.Model;
using SellingElectronicWebsite.ViewModel;

namespace SellingElectronicWebsite.Repository
{
    public interface IProductsRepository
    {
        Task<List<ProductVM>> GetAll(string sortBy);   
        Task<ProductVM> GetById(int id);
        Task<List<ProductVM>> GetByPage(int pageIndex, int pageSize, string sortBy);
        Task<ProductVM> GetByName(String name);
        Task<List<ProductVM>> SearchProductByName(string nameProduct);

        Task<int> CountProducts();
        Task<bool> Add(ProductModel model);
        Task<bool> Update(ProductModel model, int id);
        Task<bool> Delete(int id);
        Task<bool> CategoryExists(int? categoryId);
        //color
        Task<List<ColorVM>> GetAllColor(int id);
        //img
        Task<List<ImageProductsVM>> GetImgByIdProduct(int idProduct);
        Task<bool> AddImgs(List<ImageProductsModel> models);
        Task<bool> UpdateImgs(List<ImageProductsModel> models, int idProduct);
        Task<bool> DeleteImgByIdImg(int idImg);
        Task<bool> DeleteAllImgByIdProduct(int idProduct);
        Task<int> SaveImg(SaveImageModel img);
        //specification
        Task<List<ProductSpecifiactionVM>> GetSpeciByIdProduct(int idProduct);
        Task<bool> AddSpecifications(List<ProductSpecifiactionModel> models);
        Task<bool> UpdateSpecifications(List<ProductSpecifiactionModel> models, int idProduct);
        Task<bool> DeleteSpeciByIdSpeci(int idSpecification);
        Task<bool> DeleteAllSpeciByIdProduct(int idProduct);
    }
}
