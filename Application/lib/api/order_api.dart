import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shopping_app/model/order.dart';
import 'package:http/http.dart' as http;
import 'package:shopping_app/model/token_state.dart';

class OrderApi {
  final String _url = dotenv.get('ORDER_API');

  Future<List<Order>> getAllOrders({
    required TokenState token,
    required int customerId,
  }) async {
    final url = Uri.parse('$_url?customer/$customerId?status=approve');
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
      return (jsonDecode(response.body) as List<dynamic>)
          .map((e) => Order.fromJson(e))
          .toList();
    } else {
      // Ngoại lệ xảy ra
      throw Exception('Không thể lấy được danh sách: ${response.body}');
    }
  }
}
