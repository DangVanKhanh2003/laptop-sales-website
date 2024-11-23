import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shopping_app/model/category.dart';
import 'package:http/http.dart' as http;
import 'package:shopping_app/model/token_state.dart';

class CategoryApi {
  final String _url = dotenv.get('CATEGORY_LINK');

  Future<CategoryList> getAllCategory({
    required TokenState token,
  }) async {
    final url = Uri.parse(_url);
    final response = await http.get(url, headers: {
      'Authorization': token.toAuthorizationJson(),
    }).timeout(
      const Duration(seconds: 10),
    );
    // Nếu JWT Token hết hạn thì headers sẽ trả về authorization -> đè token
    if (response.headers.containsKey('Authorization')) {
      // Tham chiếu sẽ nhanh hơn tham trị
      token.clone(
        TokenState.fromJson(jsonDecode(response.headers['Authorization']!)),
      );
      await token.save();
    }
    if (response.statusCode == 200) {
      // Đã lấy được danh mục, chuyển sang đối tượng
      return CategoryList.fromJson(jsonDecode(response.body));
    } else {
      // Ngoại lệ xảy ra
      throw Exception('Không thể lấy được danh mục: ${response.body}');
    }
  }
}
