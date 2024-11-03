import 'package:shopping_app/api/product_api.dart';
import 'package:shopping_app/model/product.dart';

class ProductRepository {
  /// API Wrapper
  final ProductApi _productApi;

  /// Constructor
  ProductRepository(this._productApi);

  /// Get product by Pagination
  Future<ProductList> getProduct({
    int page = 1,
    int limit = 10,
  }) async {
    return await _productApi.getProducts(page: page, limit: limit);
  }

  Future<ProductSpecificationList> getProductSpecification({
    required int id,
  }) async {
    return await _productApi.getProductSpecificationById(id: id);
  }
}
