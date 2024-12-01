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
            CreateMap<Product, ProductVM>()
                .ForMember(dest => dest.CategoryName, opt => opt.MapFrom(src => src.Category.CategoryName))
                .ReverseMap();
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
            CreateMap<Store, StoreVM>()
                .ForMember(dest => dest.Address, opt => opt.MapFrom(src => src.Address))
                .ReverseMap();
            CreateMap<Address, AddressModel>().ReverseMap();
            CreateMap<Address, AddressVM>().ReverseMap();
            CreateMap<AccountCustomer, CustomerAccountModel>().ReverseMap();
            CreateMap<AccountCustomer, CustomerAccountVM>().ReverseMap();
            CreateMap<Customer, CustomerModel>().ReverseMap();
            CreateMap<Customer, CustomerVM>().ReverseMap();
            CreateMap<AddressCustomer, AddressBookModel>().ReverseMap();
            CreateMap<AddressCustomer, AddressBookVM>().ReverseMap();
            CreateMap<ShoppingCart, ShoppingCartItemModel>().ReverseMap();
            CreateMap<ShoppingCart, ShoppingCartItemVM>()
                .ForMember(dest => dest.ProductName, opt => opt.MapFrom(src => src.Product.ProductName))
                .ForMember(dest => dest.ColorName, opt => opt.MapFrom(src => src.Color.ColorName))
                .ReverseMap();
            CreateMap<OrderPending, OrderPendingModel>().ReverseMap();
            CreateMap<OrderPending, OrderPendingVM>()
                .ForMember(dest => dest.EmployeeName, opt => opt.MapFrom(src => src.Employee.FullName))
                .ForMember(dest => dest.CustomerName, opt => opt.MapFrom(src => src.Customer.FullName))
                .ReverseMap();
            CreateMap<ProductOrderPending, ProductOrderPendingModel>().ReverseMap();
            CreateMap<ProductOrderPending, ProductOrderPendingVM>()
                .ForMember(dest => dest.ProductName, opt => opt.MapFrom(src => src.Product.ProductName))
                .ForMember(dest => dest.ColorName, opt => opt.MapFrom(src => src.Color.ColorName))
                .ReverseMap();
            CreateMap<StoresProduct, StoreProductModel>().ReverseMap();
            CreateMap<StoresProduct, StoreProductVM>()
               .ForMember(dest => dest.Store, opt => opt.MapFrom(src => src.Store))
               .ForMember(dest => dest.Product, opt => opt.MapFrom(src => src.Product))
               .ForMember(dest => dest.Color, opt => opt.MapFrom(src => src.Color))
               .ForMember(dest => dest.Amount, opt => opt.MapFrom(src => src.Amount))
               .ReverseMap();
             CreateMap<ProductOrder, ProductOrderVM>()
               .ForMember(dest => dest.Product, opt => opt.MapFrom(src => src.Product))
               .ForMember(dest => dest.Color, opt => opt.MapFrom(src => src.Color))
               .ReverseMap();
            CreateMap<Order, OrderVM>()
                .ForMember(dest => dest.EmployeeName, opt => opt.MapFrom(src => src.Employee.FullName))
                .ForMember(dest => dest.CustomerName, opt => opt.MapFrom(src => src.Customer.FullName))
                .ForMember(dest => dest.Store, opt => opt.MapFrom(src => src.Store))
                .ReverseMap();

            CreateMap<Order, OrderOfflineModel>()
               .ReverseMap();

            CreateMap<Order, CancelOrderVM>()
               .ReverseMap();
            CreateMap<OrderPending, CancelOrderVM>()
               .ReverseMap();

            CreateMap<ProductOrder, ProductOrderCancelVM>()
                .ForMember(dest => dest.Product, opt => opt.MapFrom(src => src.Product))
                .ForMember(dest => dest.Color, opt => opt.MapFrom(src => src.Color))
                .ReverseMap();
            CreateMap<ProductOrderPending, ProductOrderCancelVM>()
                .ForMember(dest => dest.Product, opt => opt.MapFrom(src => src.Product))
                .ForMember(dest => dest.Color, opt => opt.MapFrom(src => src.Color))
                .ReverseMap();

            CreateMap<ImagesSave, SaveImageModel>()
                .ForMember(dest => dest.Extension, opt => opt.MapFrom(src => src.FileExtension))
                .ForMember(dest => dest.FileName, opt => opt.MapFrom(src => src.FileName))
              .ReverseMap();
            CreateMap<ImagesSave, SaveImageVM>()
                .ForMember(dest => dest.Extension, opt => opt.MapFrom(src => src.FileExtension))
                .ForMember(dest => dest.FileName, opt => opt.MapFrom(src => src.FileName))
              .ReverseMap();
            CreateMap<Comment, CommentModel>().ReverseMap();
            CreateMap<Comment, CommentVM>().ReverseMap();
        }
    }
}
