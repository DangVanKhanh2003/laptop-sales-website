import 'dart:convert';

import 'package:admin/model/product.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ProductApi {
  final String _url = dotenv.get('PRODUCT_LINK');

  Future<ProductList> getAllProduct() async {
    final uri = Uri.parse(_url);
    final response = await http.get(uri).timeout(const Duration(seconds: 10));
    if (response.statusCode == 200) {
      return ProductList.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(
        'Không thể fetch được sản phẩm, mã lỗi: ${response.body}',
      );
    }
  }

  Future<void> deleteProduct({
    required int productId,
  }) async {
    final uri = Uri.parse('$_url/$productId');
    final response = await http.delete(uri).timeout(const Duration(seconds: 10));
    if (response.statusCode == 200) {
      return;
    } else {
      throw Exception('Không thể xóa được sản phẩm, lỗi: ${response.body}');
    }
  }

  Future<void> addProduct({
    required String productName,
    required String brand,
    required String series,
    required double price,
    required int categoryId,
    required String? mainImg,
  }) async {
    final uri = Uri.parse(_url);
    final response = await http
        .post(uri,
            headers: {
              'Content-Type': 'application/json',
            },
            body: jsonEncode({
              'productName': productName,
              'brand': brand,
              'series': series,
              'price': price,
              'categoryId': categoryId,
              'mainImg': mainImg,
            }))
        .timeout(const Duration(seconds: 10));
    if (response.statusCode == 200) {
      return;
    } else {
      throw Exception('Không thể thêm được sản phẩm, lỗi: ${response.body}');
    }
  }

  Future<void> editProduct({
    required int productId,
    required Product product,
    required int categoryId,
  }) async {
    final uri = Uri.parse('$_url/$productId');
    final response = await http
        .put(uri,
            headers: {
              'Content-Type': 'application/json',
            },
            body: jsonEncode({
              'productName': product.productName,
              'brand': product.brand,
              'series': product.series,
              'price': product.price,
              'categoryId': categoryId,
              'mainImg': product.mainImg,
            }))
        .timeout(const Duration(seconds: 10));
    if (response.statusCode == 200) {
      return;
    } else {
      throw Exception('Không thể sửa được sản phẩm, lỗi: ${response.body}');
    }
  }
}
