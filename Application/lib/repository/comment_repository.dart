import 'package:shopping_app/api/comment_api.dart';
import 'package:shopping_app/model/comment.dart';
import 'package:shopping_app/model/token_state.dart';

class CommentRepository {
  final CommentApi _commentApi;

  CommentRepository(this._commentApi);

  Future<List<Comment>> getComments({
    required TokenState token,
    required int productId,
  }) async {
    return await _commentApi.getComments(
      token: token,
      productId: productId,
    );
  }

  Future<void> addComment({
    required TokenState token,
    required int customerId,
    required int productId,
    required String comment,
  }) async {
    return await _commentApi.addNewComment(
      token: token,
      productId: productId,
      comment: comment,
      customerId: customerId,
    );
  }
}
