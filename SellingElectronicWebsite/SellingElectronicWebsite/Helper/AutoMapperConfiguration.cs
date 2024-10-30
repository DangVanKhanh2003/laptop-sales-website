using AutoMapper;
using SellingElectronicWebsite.Entities;
using SellingElectronicWebsite.Model;
using SellingElectronicWebsite.ViewModel;

namespace SellingElectronicWebsite.Helper
{
    public class AutoMapperConfiguration : Profile
    {
        public AutoMapperConfiguration()
        {
            CreateMap<Product, ProductVM>().ReverseMap();
            CreateMap<Product, ProductModel>().ReverseMap();
            CreateMap<Color, ColorModel>().ReverseMap();
            CreateMap<Color, ColorVM>().ReverseMap();
            CreateMap<ImageProduct, ImageProductsModel>().ReverseMap();
            CreateMap<ImageProduct, ImageProductsVM>().ReverseMap();
            CreateMap<ProductSpecifiaction, ProductSpecifiactionModel>().ReverseMap();
            CreateMap<ProductSpecifiaction, ProductSpecifiactionVM>().ReverseMap();
            CreateMap<Category, CategoryModel>().ReverseMap();
            CreateMap<Category, CategoryVM>().ReverseMap();
            CreateMap<Sale, SalesModel>().ReverseMap();
            CreateMap<Sale, SalesVM>().ReverseMap();
            CreateMap<Store, StoreModel>().ReverseMap();
            CreateMap<Store, StoreVM>().ReverseMap();
        }
    }
}
