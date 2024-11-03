import 'dart:convert';

import 'package:shopping_app/model/product.dart';
import 'package:http/http.dart' as http;

class ProductApi {
  /// URL cho API

  final String _url = 'http://dangvankhanhblog.io.vn:7138/api/employee/Product';

  /// Phương thức lấy toàn bộ sản phẩm. Không nên sử dụng trong production vì nó sẽ fetch toàn bộ sản phẩm => Lâu.
  /// Viết để test

  Future<ProductList> getAllProduct() async {
    final uri = Uri.parse('$_url/getAllProduct');
    final response = await http.get(uri).timeout(const Duration(seconds: 10));
    if (response.statusCode == 200) {
      return ProductList.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(
        'Không thể fetch được product, mã lỗi: ${response.statusCode}',
      );
    }
  }

  /// Phương thức lấy các sản phẩm. Nên sử dụng trong production vì nó sẽ fetch n sản phẩm => Nhanh.

  Future<ProductList> getProducts({
    required int page,
    required int limit,
  }) async {
    final uri = Uri.parse('$_url/page?pageIndex=$page&pageSize=$limit');
    final response = await http.get(uri).timeout(const Duration(seconds: 10));
    if (response.statusCode == 200) {
      return ProductList.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(
        'Không thể fetch được product, mã lỗi: ${response.statusCode}',
      );
    }
  }

  Future<ProductSpecificationList> getProductSpecificationById({
    required int id,
  }) async {
    final uri =
        Uri.parse('$_url/GetAllSpecificationsByIdProduct?ProductId=$id');
    final response = await http.get(uri).timeout(const Duration(seconds: 10));
    if (response.statusCode == 200) {
      return ProductSpecificationList.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(
        'Không thể fetch được product, mã lỗi: ${response.statusCode}',
      );
    }
  }
}
