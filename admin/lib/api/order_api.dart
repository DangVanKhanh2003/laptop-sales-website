import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:admin/model/order.dart';
import 'package:http/http.dart' as http;

class OrderApi {
  final String _url = dotenv.get('ORDER_API');

  Future<List<Order>> getAllOrders({
    required String status,
  }) async {
    final url = Uri.parse('$_url?status=$status');
    final response = await http.get(url).timeout(
          const Duration(seconds: 10),
        );
    if (response.statusCode == 200) {
      return (jsonDecode(response.body) as List<dynamic>)
          .map((e) => Order.fromJson(e))
          .toList();
    } else {
      throw Exception('Không thể lấy được danh sách: ${response.body}');
    }
  }

  Future<void> approveOrder({
    required int orderId,
  }) async {
    final url = Uri.parse('$_url/Export?idOrder=$orderId&employeeId=1');
    final response = await http.put(url).timeout(
          const Duration(seconds: 10),
        );
    if (response.statusCode == 200) {
      return;
    } else {
      throw Exception('Không thể lấy được danh sách: ${response.body}');
    }
  }

  Future<void> cancelOrder({
    required int orderId,
  }) async {
    final url = Uri.parse('$_url/Cancel?idOrder=$orderId&employeeId=1');
    final response = await http.put(url).timeout(
          const Duration(seconds: 10),
        );
    if (response.statusCode == 200) {
      return;
    } else {
      throw Exception('Không thể lấy được danh sách: ${response.body}');
    }
  }
}
