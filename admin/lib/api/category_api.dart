import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:admin/model/category.dart';
import 'package:http/http.dart' as http;

class CategoryApi {
  final String _url = dotenv.get('CATEGORY_LINK');

  Future<CategoryList> getAllCategory() async {
    final url = Uri.parse(_url);
    final response = await http.get(url).timeout(
          const Duration(seconds: 10),
        );
    if (response.statusCode == 200) {
      return CategoryList.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Không thể lấy được danh mục: ${response.body}');
    }
  }

  Future<void> deleteCategory({
    required int categoryId,
  }) async {
    final url = Uri.parse('$_url/$categoryId');
    final response = await http.delete(url).timeout(
          const Duration(seconds: 10),
        );
    if (response.statusCode == 200) {
      return;
    } else {
      throw Exception('Không thể xóa được danh mục: ${response.body}');
    }
  }

  Future<void> editCategory({
    required Category category,
  }) async {
    final url = Uri.parse('$_url/${category.categoryId!}');
    final response = await http
        .put(url,
            headers: {
              'Content-Type': 'application/json',
            },
            body: jsonEncode(category.toJson()))
        .timeout(
          const Duration(seconds: 10),
        );
    if (response.statusCode == 200) {
      return;
    } else {
      throw Exception('Không thể sửa được danh mục: ${response.body}');
    }
  }

  Future<void> addCategory({
    required Category category,
  }) async {
    final url = Uri.parse(_url);
    final response = await http
        .post(url,
            headers: {
              'Content-Type': 'application/json',
            },
            body: jsonEncode(category.toJson()))
        .timeout(
          const Duration(seconds: 10),
        );
    if (response.statusCode == 200) {
      return;
    } else {
      throw Exception('Không thể thêm được danh mục: ${response.body}');
    }
  }
}
