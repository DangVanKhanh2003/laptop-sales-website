import 'package:admin/api/product_api.dart';
import 'package:admin/model/product.dart';

class ProductRepository {
  /// API Wrapper
  final ProductApi _productApi;

  /// Constructor
  ProductRepository(this._productApi);

  /// Get all product
  Future<ProductList> getProduct() async {
    return await _productApi.getAllProduct();
  }

  /// Get product by category id
  Future<ProductList> getProductByCategoryId({
    required int categoryId,
  }) async {
    return await _productApi.getProductsByCategoryId(categoryId: categoryId);
  }

  Future<ProductList> getProductByName({
    required String name,
  }) async {
    return await _productApi.getProductsByName(name: name);
  }

  Future<Product> getProductById({
    required int id,
  }) async {
    return await _productApi.getProductById(productId: id);
  }

  Future<ProductSpecificationList> getProductSpecification({
    required int id,
  }) async {
    return await _productApi.getProductSpecificationById(id: id);
  }
}
