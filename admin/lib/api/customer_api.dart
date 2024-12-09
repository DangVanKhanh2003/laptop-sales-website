import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:admin/model/customer_info.dart';

class CustomerApi {
  final String _url = dotenv.get('CUSTOMER_LINK');
  final String _urlInfo = dotenv.get('CUSTOMER_INFO_LINK');

  Future<CustomerInfo> getCustomerInfoById({
    required int customerId,
  }) async {
    final url = Uri.parse(
      '$_urlInfo/$customerId',
    );
    final response = await http.get(url).timeout(
          const Duration(seconds: 10),
        );
    if (response.statusCode == 200) {
      return CustomerInfo.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(
        'Lỗi xảy ra, không thể lấy được thông tin người dùng: ${response.body}',
      );
    }
  }

  Future<CustomerInfo> updateCustomerInfo({
    required CustomerInfo customerInfo,
  }) async {
    final url = Uri.parse(
      '$_urlInfo/?id=${customerInfo.customerId!}',
    );
    final response = await http
        .put(url,
            headers: {
              'Content-Type': 'application/json',
            },
            body: jsonEncode(customerInfo.toJson()))
        .timeout(
          const Duration(seconds: 10),
        );
    if (response.statusCode == 200) {
      return CustomerInfo.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(
        'Lỗi xảy ra, không thể sửa được thông tin người dùng: ${response.body}',
      );
    }
  }

  Future<void> register({
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
      return;
    } else {
      throw Exception('Lỗi đăng ký: ${response.body}');
    }
  }

  Future<void> deleteCustomer({
    required String guid,
  }) async {
    final url = Uri.parse(
      '$_url?idAccount=$guid',
    );
    final response = await http.delete(url).timeout(
          const Duration(seconds: 10),
        );
    if (response.statusCode == 200) {
      return;
    } else {
      throw Exception('Lỗi đăng ký: ${response.body}');
    }
  }

  Future<void> updateCustomerPassword({
    required String email,
    required String password,
  }) async {
    final url = Uri.parse(
      '$_url/ChangePassword2',
    );
    final response = await http
        .put(url,
            headers: {
              'Content-Type': 'application/json',
            },
            body: jsonEncode({
              'email': email,
              'newPassword': password,
            }))
        .timeout(
          const Duration(seconds: 10),
        );
    if (response.statusCode == 200) {
      return;
    } else {
      throw Exception(
        'Lỗi xảy ra, không thể cập nhật được mật khẩu: ${response.body}',
      );
    }
  }

  Future<List<CustomerAccount>> getAllCustomer() async {
    final url = Uri.parse(_url);
    final response = await http.get(url).timeout(
          const Duration(seconds: 10),
        );
    if (response.statusCode == 200) {
      return (jsonDecode(response.body) as List<dynamic>).map((e) => CustomerAccount.fromJson(e)).toList();
    } else {
      throw Exception(
        'Lỗi xảy ra, không thể cập nhật được mật khẩu: ${response.body}',
      );
    }
  }
}
