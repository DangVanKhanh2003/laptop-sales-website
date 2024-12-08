import 'package:admin/api/comment_api.dart';
import 'package:admin/model/comment.dart';

class CommentRepository {
  final CommentApi _commentApi;

  CommentRepository(this._commentApi);

  Future<List<Comment>> getComments({
    required int productId,
  }) async {
    return await _commentApi.getComments(
      productId: productId,
    );
  }

  Future<void> addComment({
    required int customerId,
    required int productId,
    required String comment,
  }) async {
    return await _commentApi.addNewComment(
      productId: productId,
      comment: comment,
      customerId: customerId,
    );
  }
}
