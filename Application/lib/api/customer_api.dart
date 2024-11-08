import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shopping_app/model/token_state.dart';

class CustomerApi {
  final String _url = dotenv.get('CUSTOMER_LINK');

  Future<TokenState> login({
    required String email,
    required String password,
  }) async {
    final url = Uri.parse('$_url/Login?email=$email&password=$password');
    final response = await http.get(url).timeout(
          const Duration(seconds: 10),
        );
    if (response.statusCode == 200) {
      // Đã lấy được danh mục, chuyển sang đối tượng
      final token = TokenState.fromJson(jsonDecode(response.body));
      await token.save();
      return token;
    } else {
      // Ngoại lệ xảy ra
      throw Exception('Lỗi đăng nhập: ${response.body}');
    }
  }

  Future<dynamic> register({
    required String email,
    required String password,
  }) async {
    final url = Uri.parse(
      '$_url/RegisterAccount?email=$email&password=$password',
    );
    final response = await http.post(url).timeout(
          const Duration(seconds: 10),
        );
    if (response.statusCode == 200) {
      // Đã lấy được danh mục, chuyển sang đối tượng
      return;
    } else {
      // Ngoại lệ xảy ra
      throw Exception('Lỗi đăng ký: ${response.statusCode}');
    }
  }
}
