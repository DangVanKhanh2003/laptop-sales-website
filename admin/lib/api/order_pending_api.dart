import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:admin/model/order_pending.dart';
import 'package:http/http.dart' as http;

class OrderPendingApi {
  final String _url = dotenv.get('ORDER_PENDING_API');

  Future<List<OrderPending>> getAllOrderPending({
    String status = 'pending',
  }) async {
    final url = Uri.parse('$_url?status=$status');
    final response = await http.get(url).timeout(
          const Duration(seconds: 10),
        );
    if (response.statusCode == 200) {
      return (jsonDecode(response.body) as List<dynamic>).map((e) => OrderPending.fromJson(e)).toList();
    } else {
      throw Exception('Không thể lấy được danh sách: ${response.body}');
    }
  }

  Future<void> cancelOrderPending({
    required int orderId,
  }) async {
    final url = Uri.parse('$_url/$orderId/Customer-Cancel');
    final response = await http.put(url).timeout(
          const Duration(seconds: 10),
        );
    if (response.statusCode == 200) {
      return;
    } else {
      throw Exception('Không thể lấy được danh sách: ${response.body}');
    }
  }

  Future<bool> changeOrderPending({
    required OrderPending order,
    required String status,
  }) async {
    final url = Uri.parse('$_url/${order.orderPendingId}/Employee/1/Change-status?status=$status&idStore=1');
    final response = await http.put(url).timeout(
          const Duration(seconds: 10),
        );
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Không thể thay được danh sách: ${response.body}');
    }
  }
}
