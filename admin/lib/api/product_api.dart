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

  Future<ProductList> getProductsByCategoryId({
    required int categoryId,
  }) async {
    final uri = Uri.parse('$_url/Category/$categoryId');
    final response = await http.get(uri).timeout(const Duration(seconds: 10));
    if (response.statusCode == 200) {
      return ProductList.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(
        'Không thể fetch được sản phẩm, mã lỗi: ${response.body}',
      );
    }
  }

  Future<Product> getProductById({
    required int productId,
  }) async {
    final uri = Uri.parse('$_url/$productId');
    final response = await http.get(uri).timeout(const Duration(seconds: 10));

    if (response.statusCode == 200) {
      return Product.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(
        'Không thể fetch được sản phẩm, mã lỗi: ${response.body}',
      );
    }
  }

  Future<ProductList> getProductsByName({
    required String name,
  }) async {
    final uri = Uri.parse('$_url/Search?nameProduct=$name');
    final response = await http.get(uri).timeout(const Duration(seconds: 10));
    if (response.statusCode == 200) {
      return ProductList.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(
        'Không thể fetch được sản phẩm, mã lỗi: ${response.body}',
      );
    }
  }

  Future<ProductSpecificationList> getProductSpecificationById({
    required int id,
  }) async {
    final uri = Uri.parse('$_url/$id/Specification');
    final response = await http.get(uri).timeout(const Duration(seconds: 10));
    if (response.statusCode == 200) {
      return ProductSpecificationList.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(
        'Không thể fetch được sản phẩm, mã lỗi: ${response.body}',
      );
    }
  }
}
