import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shopping_app/model/order_pending.dart';
import 'package:http/http.dart' as http;
import 'package:shopping_app/model/token_state.dart';

class OrderPendingApi {
  final String _url = dotenv.get('ORDER_PENDING_API');

  Future<List<OrderPending>> getAllOrderPending({
    required TokenState token,
    String status = 'pending',
  }) async {
    final url = Uri.parse('$_url?status=$status');
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
          .map((e) => OrderPending.fromJson(e))
          .toList();
    } else {
      // Ngoại lệ xảy ra
      throw Exception('Không thể lấy được danh sách: ${response.body}');
    }
  }

  Future<void> cancelOrderPending({
    required TokenState token,
    required int orderId,
  }) async {
    final url = Uri.parse('$_url/$orderId/Customer-Cancel');
    final response = await http.put(url, headers: {
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
      return;
    } else {
      // Ngoại lệ xảy ra
      throw Exception('Không thể lấy được danh sách: ${response.body}');
    }
  }

  Future<bool> addOrderPending({
    required TokenState token,
    required OrderPending order,
  }) async {
    final url = Uri.parse(_url);
    final response = await http
        .post(url,
            headers: {
              'Authorization': token.toAuthorizationJson(),
              'Content-Type': 'application/json',
            },
            body: jsonEncode(
              {
                'customerId': order.customerId!,
                'listProductOrederPending': [
                  ...order.listProductOrederPending!.map(
                    (e) => {
                      "productId": e.productId!,
                      "amount": e.amount!,
                      "colorId": 1,
                    },
                  ),
                ],
              },
            ))
        .timeout(
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
      return true;
    } else {
      // Ngoại lệ xảy ra
      throw Exception('Không thể lấy được danh sách: ${response.body}');
    }
  }
}
