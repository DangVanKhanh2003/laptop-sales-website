using AutoMapper;
using SellingElectronicWebsite.Entities;
using SellingElectronicWebsite.Model;
using SellingElectronicWebsite.ViewModel;

namespace SellingElectronicWebsite.Helper
{
    public class AutoMapperConfiguration: Profile
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
            CreateMap<Address, AddressModel>().ReverseMap();
            CreateMap<Address, AddressVM>().ReverseMap();
            CreateMap<AccountCustomer, CustomerAccountModel>().ReverseMap();
            CreateMap<AccountCustomer, CustomerAccountVM>().ReverseMap();
            CreateMap<Customer, CustomerModel>().ReverseMap();
            CreateMap<Customer, CustomerVM>().ReverseMap();
            CreateMap<AddressCustomer, AddressBookModel>().ReverseMap();
            CreateMap<AddressCustomer, AddressBookVM>().ReverseMap();
            CreateMap<ShoppingCart, ShoppingCartItemModel>().ReverseMap();
            CreateMap<ShoppingCart, ShoppingCartItemVM>().ReverseMap();
            CreateMap<OrderPending, OrderPendingModel>().ReverseMap();
            CreateMap<OrderPending, OrderPendingVM>().ReverseMap();
            CreateMap<ProductOrderPending, ProductOrderPendingModel>().ReverseMap();
            CreateMap<ProductOrderPending, ProductOrderPendingVM>().ReverseMap();
            CreateMap<StoresProduct, StoreProductModel>().ReverseMap();
            CreateMap<StoresProduct, StoreProductVM>()
           .ForMember(dest => dest.Store, opt => opt.MapFrom(src => src.Store))       
           .ForMember(dest => dest.Product, opt => opt.MapFrom(src => src.Product))   
           .ForMember(dest => dest.Color, opt => opt.MapFrom(src => src.Color))       
           .ForMember(dest => dest.Amount, opt => opt.MapFrom(src => src.Amount))
           .ReverseMap();
        }
    }
}
