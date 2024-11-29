import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shopping_app/model/comment.dart';
import 'package:http/http.dart' as http;
import 'package:shopping_app/model/token_state.dart';

class CommentApi {
  final String _url = dotenv.get('COMMENT_API');

  Future<List<Comment>> getComments({
    required TokenState token,
    required int productId,
  }) async {
    final url = Uri.parse('$_url?idProduct=$productId');
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
          .map((e) => Comment.fromJson(e))
          .toList();
    } else {
      // Ngoại lệ xảy ra
      throw Exception('Không thể lấy được danh sách: ${response.body}');
    }
  }

  Future<void> addNewComment({
    required TokenState token,
    required int customerId,
    required int productId,
    required String comment,
  }) async {
    final url = Uri.parse(_url);
    final response = await http
        .post(url,
            headers: {
              'Authorization': token.toAuthorizationJson(),
              'Content-Type': 'application/json',
            },
            body: jsonEncode({
              'customerId': customerId,
              'productId': productId,
              'commentDetail': comment,
              'parentId': null,
              'toCustomerId': null,
            }))
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
      return;
    } else {
      // Ngoại lệ xảy ra
      throw Exception('Không thể lấy được danh sách: ${response.body}');
    }
  }
}
