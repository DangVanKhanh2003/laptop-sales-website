import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:admin/model/order.dart';
import 'package:http/http.dart' as http;

class OrderApi {
  final String _url = dotenv.get('ORDER_API');

  Future<List<Order>> getAllOrders({
    required int customerId,
  }) async {
    final url = Uri.parse('$_url?customer/$customerId?status=approve');
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
}
