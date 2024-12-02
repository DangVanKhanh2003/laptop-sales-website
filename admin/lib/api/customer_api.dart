import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:admin/model/customer_info.dart';

class CustomerApi {
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
          'Lỗi xảy ra, không thể lấy được thông tin người dùng: ${response.body}');
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

  Future<CustomerInfo> updateCustomerPassword({
    required String email,
    required String oldPassword,
    required String newPassword,
  }) async {
    final url = Uri.parse(
      '$_urlInfo?email=$email&password=$oldPassword&newPassword=a$newPassword',
    );
    final response = await http.put(url).timeout(
          const Duration(seconds: 10),
        );
    if (response.statusCode == 200) {
      return CustomerInfo.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(
        'Lỗi xảy ra, không thể cập nhật được mật khẩu: ${response.body}',
      );
    }
  }
}
