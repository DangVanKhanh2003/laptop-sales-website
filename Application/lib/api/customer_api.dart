import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shopping_app/model/customer_info.dart';
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

  final String _urlInfo = dotenv.get('CUSTOMER_INFO_LINK');

  Future<CustomerInfo> getCustomerInfoById({
    required int customerId,
    required TokenState token,
  }) async {
    final url = Uri.parse(
      '$_urlInfo/GetAccByIdCustomer1',
    );
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
      return CustomerInfo.fromJson(jsonDecode(response.body));
    } else {
      // Ngoại lệ xảy ra
      throw Exception(
          'Lỗi xảy ra, không thể lấy được thông tin người dùng: ${response.statusCode}');
    }
  }
}
