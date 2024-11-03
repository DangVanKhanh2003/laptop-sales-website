import 'dart:convert';

import 'package:shopping_app/model/category.dart';
import 'package:http/http.dart' as http;

class CategoryApi {
  final String _url =
      "http://dangvankhanhblog.io.vn:7138/api/employee/CategoryControler";

  Future<CategoryList> getAllCategory() async {
    final url = Uri.parse('$_url/getAllCategory');
    final response = await http.get(url).timeout(
          const Duration(seconds: 10),
        );
    if (response.statusCode == 200) {
      // Đã lấy được danh mục, chuyển sang đối tượng
      return CategoryList.fromJson(jsonDecode(response.body));
    } else {
      // Ngoại lệ xảy ra
      throw Exception('Cannot get all category: ${response.statusCode}');
    }
  }
}
