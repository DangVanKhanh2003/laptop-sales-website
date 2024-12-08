import 'package:shopping_app/api/product_api.dart';
import 'package:shopping_app/model/product.dart';
import 'package:shopping_app/model/token_state.dart';

class ProductRepository {
  /// API Wrapper
  final ProductApi _productApi;

  /// Constructor
  ProductRepository(this._productApi);

  /// Get product by Pagination
  Future<ProductList> getProduct({
    int page = 1,
    int limit = 10,
    required TokenState token,
  }) async {
    return await _productApi.getProducts(
        page: page, limit: limit, token: token);
  }

  /// Get product by category id
  Future<ProductList> getProductByCategoryId({
    required int categoryId,
    required TokenState token,
  }) async {
    return await _productApi.getProductsByCategoryId(
        categoryId: categoryId, token: token);
  }

  /// Get product by category id
  Future<ProductList> getProductByName({
    required String name,
    required TokenState token,
  }) async {
    return await _productApi.getProductsByName(name: name, token: token);
  }

  /// Get product by category id
  Future<Product> getProductById({
    required int id,
    required TokenState token,
  }) async {
    return await _productApi.getProductById(token: token, productId: id);
  }

  /// Get product by Specification

  Future<ProductSpecificationList> getProductSpecification({
    required int id,
    required TokenState token,
  }) async {
    return await _productApi.getProductSpecificationById(id: id, token: token);
  }
}
