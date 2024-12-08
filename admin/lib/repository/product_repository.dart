import 'package:admin/api/product_api.dart';
import 'package:admin/model/product.dart';

class ProductRepository {
  final ProductApi _productApi;

  ProductRepository(this._productApi);

  Future<ProductList> getProduct() async {
    return await _productApi.getAllProduct();
  }

  Future<void> addProduct({
    required String productName,
    required String brand,
    required String series,
    required double price,
    required int categoryId,
    required String? mainImg,
  }) async {
    return await _productApi.addProduct(
      productName: productName,
      brand: brand,
      series: series,
      price: price,
      categoryId: categoryId,
      mainImg: mainImg,
    );
  }

  Future<void> editProduct({
    required int productId,
    required Product product,
    required int categoryId,
  }) async {
    return await _productApi.editProduct(
      categoryId: categoryId,
      product: product,
      productId: productId,
    );
  }

  Future<void> deleteProduct({
    required int productId,
  }) async {
    return await _productApi.deleteProduct(
      productId: productId,
    );
  }
}
