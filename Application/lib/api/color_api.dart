import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shopping_app/model/color.dart';
import 'package:shopping_app/model/token_state.dart';

class CategoryApi {
  final String _url = dotenv.get('COLOR_LINK');

  Future<ColorList> getAllColor({
    required TokenState token,
  }) async {
    final url = Uri.parse(_url);
    final response = await http.get(url, headers: {
      'Authorization': token.toAuthorizationJson(),
    }).timeout(
      const Duration(seconds: 10),
    );
    if (response.headers.containsKey('Authorization')) {
      token.clone(
        TokenState.fromJson(jsonDecode(response.headers['Authorization']!)),
      );
      await token.save();
    }
    if (response.statusCode == 200) {
      // Đã lấy được danh mục, chuyển sang đối tượng
      return ColorList.fromJson(jsonDecode(response.body));
    } else {
      // Ngoại lệ xảy ra
      throw Exception('Cannot get all color: ${response.body}');
    }
  }
}
