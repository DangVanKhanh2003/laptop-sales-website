import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shopping_app/model/color.dart';

class CategoryApi {
  final String _url = 'http://dangvankhanhblog.io.vn:7138/api/employee/Color';

  Future<ColorList> getAllCategory() async {
    final url = Uri.parse('$_url/getAllColor');
    final response = await http.get(url).timeout(
          const Duration(seconds: 10),
        );
    if (response.statusCode == 200) {
      // Đã lấy được danh mục, chuyển sang đối tượng
      return ColorList.fromJson(jsonDecode(response.body));
    } else {
      // Ngoại lệ xảy ra
      throw Exception('Cannot get all color: ${response.statusCode}');
    }
  }
}
