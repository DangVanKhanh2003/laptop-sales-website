import 'dart:convert';

import 'package:shopping_app/model/product.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shopping_app/model/token_state.dart';

class ProductApi {
  /// URL cho API

  final String _url = dotenv.get('PRODUCT_LINK');

  /// Phương thức lấy toàn bộ sản phẩm. Không nên sử dụng trong production vì nó sẽ fetch toàn bộ sản phẩm => Lâu.
  /// Viết để test

  Future<ProductList> getAllProduct({
    required TokenState token,
  }) async {
    final uri = Uri.parse(_url);
    final response = await http.get(uri, headers: {
      'Authorization': token.toAuthorizationJson(),
    }).timeout(const Duration(seconds: 10));
    if (response.headers.containsKey('Authorization')) {
      token.clone(
        TokenState.fromJson(jsonDecode(response.headers['Authorization']!)),
      );
      await token.save();
    }
    if (response.statusCode == 200) {
      return ProductList.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(
        'Không thể fetch được sản phẩm, mã lỗi: ${response.body}',
      );
    }
  }

  /// Phương thức lấy các sản phẩm. Nên sử dụng trong production vì nó sẽ fetch n sản phẩm => Nhanh.

  Future<ProductList> getProducts({
    required int page,
    required int limit,
    required TokenState token,
  }) async {
    final uri = Uri.parse('$_url/Page?pageIndex=$page&pageSize=$limit');
    final response = await http.get(uri, headers: {
      'Authorization': token.toAuthorizationJson(),
    }).timeout(const Duration(seconds: 10));
    if (response.headers.containsKey('Authorization')) {
      token.clone(
        TokenState.fromJson(jsonDecode(response.headers['Authorization']!)),
      );
      await token.save();
    }
    if (response.statusCode == 200) {
      return ProductList.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(
        'Không thể fetch được sản phẩm, mã lỗi: ${response.body}',
      );
    }
  }

  /// Phương thức lấy các sản phẩm theo mã danh mục

  Future<ProductList> getProductsByCategoryId({
    required int categoryId,
    required TokenState token,
  }) async {
    final uri = Uri.parse('$_url/Category/$categoryId');
    final response = await http.get(uri, headers: {
      'Authorization': token.toAuthorizationJson(),
    }).timeout(const Duration(seconds: 10));
    if (response.headers.containsKey('Authorization')) {
      token.clone(
        TokenState.fromJson(jsonDecode(response.headers['Authorization']!)),
      );
      await token.save();
    }
    if (response.statusCode == 200) {
      return ProductList.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(
        'Không thể fetch được sản phẩm, mã lỗi: ${response.body}',
      );
    }
  }

  /// Phương thức lấy các sản phẩm theo mã sản phẩm

  Future<Product> getProductById({
    required int productId,
    required TokenState token,
  }) async {
    final uri = Uri.parse('$_url/$productId');
    final response = await http.get(uri, headers: {
      'Authorization': token.toAuthorizationJson(),
    }).timeout(const Duration(seconds: 10));
    if (response.headers.containsKey('Authorization')) {
      token.clone(
        TokenState.fromJson(jsonDecode(response.headers['Authorization']!)),
      );
      await token.save();
    }
    if (response.statusCode == 200) {
      return Product.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(
        'Không thể fetch được sản phẩm, mã lỗi: ${response.body}',
      );
    }
  }

  /// Phương thức lấy các sản phẩm theo mã danh mục

  Future<ProductList> getProductsByName({
    required String name,
    required TokenState token,
  }) async {
    final uri = Uri.parse('$_url/Search?nameProduct=$name');
    final response = await http.get(uri, headers: {
      'Authorization': token.toAuthorizationJson(),
    }).timeout(const Duration(seconds: 10));
    if (response.headers.containsKey('Authorization')) {
      token.clone(
        TokenState.fromJson(jsonDecode(response.headers['Authorization']!)),
      );
      await token.save();
    }
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
    required TokenState token,
  }) async {
    final uri = Uri.parse('$_url/$id/Specification');
    final response = await http.get(uri, headers: {
      'Authorization': token.toAuthorizationJson(),
    }).timeout(const Duration(seconds: 10));
    if (response.headers.containsKey('Authorization')) {
      token.clone(
        TokenState.fromJson(jsonDecode(response.headers['Authorization']!)),
      );
      await token.save();
    }
    if (response.statusCode == 200) {
      return ProductSpecificationList.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(
        'Không thể fetch được sản phẩm, mã lỗi: ${response.body}',
      );
    }
  }
}
