import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shopping_app/model/cart.dart';
import 'package:http/http.dart' as http;
import 'package:shopping_app/model/token_state.dart';

class CartApi {
  final String _url = dotenv.get('CART_LINK');

  Future<CartList> getAllItems({
    required TokenState token,
    required int customerId,
  }) async {
    final url = Uri.parse('$_url/?idCustomer=$customerId');
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
      // Đã lấy được giỏ hàng, chuyển sang đối tượng
      return CartList.fromJson(jsonDecode(response.body));
    } else {
      // Ngoại lệ xảy ra
      throw Exception('Không thể lấy được giỏ hàng: ${response.body}');
    }
  }

  Future<void> addItem({
    required TokenState token,
    required Cart cart,
  }) async {
    final url = Uri.parse(_url);
    final response = await http
        .post(
          url,
          headers: {
            'Authorization': token.toAuthorizationJson(),
            'Content-Type': 'application/json',
          },
          body: jsonEncode(cart.toJson()),
        )
        .timeout(const Duration(seconds: 10));
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
      throw Exception('Không thể thêm vào giỏ hàng: ${response.body}');
    }
  }

  Future<void> updateItem({
    required TokenState token,
    required CartItem cart,
  }) async {
    final url = Uri.parse(
      '$_url/${cart.shoppingCartItemId}?amount=${cart.amount}',
    );
    final response = await http.put(
      url,
      headers: {
        'Authorization': token.toAuthorizationJson(),
      },
    ).timeout(const Duration(seconds: 10));
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
      throw Exception('Không thể sửa được giỏ hàng: ${response.body}');
    }
  }

  Future<void> deleteItem({
    required TokenState token,
    required CartItem cart,
  }) async {
    final url = Uri.parse(
      '$_url/${cart.shoppingCartItemId}',
    );
    final response = await http.delete(
      url,
      headers: {
        'Authorization': token.toAuthorizationJson(),
      },
    ).timeout(const Duration(seconds: 10));
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
      throw Exception('Không thể xoá được giỏ hàng: ${response.body}');
    }
  }
}
