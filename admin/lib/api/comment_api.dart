import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:admin/model/comment.dart';
import 'package:http/http.dart' as http;

class CommentApi {
  final String _url = dotenv.get('COMMENT_API');

  Future<List<Comment>> getComments({
    required int productId,
  }) async {
    final url = Uri.parse('$_url?idProduct=$productId');
    final response = await http.get(url).timeout(
          const Duration(seconds: 10),
        );
    if (response.statusCode == 200) {
      return (jsonDecode(response.body) as List<dynamic>)
          .map((e) => Comment.fromJson(e))
          .toList();
    } else {
      throw Exception('Không thể lấy được danh sách: ${response.body}');
    }
  }

  Future<void> addNewComment({
    required int customerId,
    required int productId,
    required String comment,
  }) async {
    final url = Uri.parse(_url);
    final response = await http
        .post(url,
            headers: {
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
    if (response.statusCode == 200) {
      return;
    } else {
      throw Exception('Không thể lấy được danh sách: ${response.body}');
    }
  }
}
