import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shopping_app/model/history.dart';
import 'package:shopping_app/model/token_state.dart';
import 'package:http/http.dart' as http;

class HistoryApi {
  final String _url = dotenv.get('HISTORY_LINK');

  Future<List<HistorySuccess>> getSuccessHistory({
    required TokenState token,
    required int customerId,
  }) async {
    final url = Uri.parse('$_url/SuccessOrder?idCustomer=$customerId');
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
          .map((e) => HistorySuccess.fromJson(e))
          .toList();
    } else {
      // Ngoại lệ xảy ra
      throw Exception('Không thể lấy được danh sách: ${response.body}');
    }
  }

  Future<List<HistoryCancel>> getCancelHistory({
    required TokenState token,
    required int customerId,
  }) async {
    final url = Uri.parse('$_url/CancelOrder?idCustomer=$customerId');
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
          .map((e) => HistoryCancel.fromJson(e))
          .toList();
    } else {
      // Ngoại lệ xảy ra
      throw Exception('Không thể lấy được danh sách: ${response.body}');
    }
  }
}
