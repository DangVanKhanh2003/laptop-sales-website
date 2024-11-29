import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:shopping_app/model/comment.dart';
import 'package:shopping_app/provider/token_provider.dart';
import 'package:shopping_app/repository/comment_repository.dart';
import 'package:shopping_app/screen/exception/exception_page.dart';
import 'package:shopping_app/service/getit_helper.dart';

class ProductComment extends ConsumerStatefulWidget {
  const ProductComment({
    super.key,
    required this.productId,
  });

  final int productId;

  @override
  ConsumerState<ProductComment> createState() => _ProductCommentState();
}

class _ProductCommentState extends ConsumerState<ProductComment> {
  late Future<List<Comment>> _future;

  late TextEditingController _controller;

  @override
  void initState() {
    _future = GetItHelper.get<CommentRepository>().getComments(
      token: ref.read(tokenProvider),
      productId: widget.productId,
    );
    _controller = TextEditingController(text: '');
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _onSuccess(String message) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Thành công'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Future<void> _onError(String message) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Thất bại'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _sendComment() async {
    try {
      final comment = _controller.text;
      _controller.text = '';
      if (comment.trim().isEmpty) {
        throw Exception('Bình luận không thể rỗng');
      }
      await GetItHelper.get<CommentRepository>().addComment(
        token: ref.read(tokenProvider),
        productId: widget.productId,
        comment: comment,
        customerId: ref.read(tokenProvider.notifier).customerId,
      );
      _onSuccess('Đã thêm bình luận thành công');
      setState(() {
        _future = GetItHelper.get<CommentRepository>().getComments(
          token: ref.read(tokenProvider),
          productId: widget.productId,
        );
      });
    } catch (e) {
      _onError(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: LinearProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(
            child: ExceptionPage(
              message: snapshot.error.toString(),
            ),
          );
        } else if (snapshot.hasData) {
          final data = snapshot.data!;
          return Column(
            children: [
              Card(
                child: ListTile(
                  leading: Icon(Symbols.book),
                  title: Text('Viết bình luận của bạn'),
                  subtitle: TextField(
                    controller: _controller,
                  ),
                  trailing: IconButton(
                    onPressed: _sendComment,
                    icon: Icon(Symbols.send),
                  ),
                ),
              ),
              ...data.map(
                (e) => Card(
                  child: ListTile(
                    leading: Image.asset(
                      'assets/images/user.png',
                      width: 40,
                      height: 40,
                    ),
                    title: Text(e.customer!.fullName!),
                    subtitle: Text(e.commentDetail!),
                    trailing: Text(e.commentDate!),
                  ),
                ),
              ),
            ],
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
