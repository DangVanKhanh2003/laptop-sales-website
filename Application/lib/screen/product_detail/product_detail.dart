// product_detail.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_app/model/product.dart';
import 'package:shopping_app/screen/product_detail/product_navbar.dart';
import 'package:shopping_app/screen/product_detail/product_profile.dart';
import 'package:shopping_app/screen/product_detail/product_specification.dart';
import 'package:shopping_app/service/gemini_helper.dart';
import 'package:shopping_app/service/getit_helper.dart';
import 'package:shimmer/shimmer.dart';
import 'package:material_symbols_icons/symbols.dart';

class ProductDetail extends ConsumerWidget {
  const ProductDetail({
    super.key,
    required this.product,
  });

  final Product product;

  void _askGemini(
    BuildContext context,
    WidgetRef ref,
  ) async {
    final future = GetItHelper.get<GeminiHelper>().ask(
      message:
          'Bạn nghĩ sao về sản phẩm này\n Tên: ${product.productName}, Giá: ${product.price}, Thông tin chi tiết bạn có thể tự tìm kiếm trên Google. Bạn hãy đánh giá sản phẩm này so với các sản phẩm điện tử hiện nay. Kết quả bằng tiếng việt làm ơn. Đừng cung cấp thông tin thừa như so sánh với sản phẩm khác',
    );
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Đánh giá của AI về sản phẩm'),
        content: FutureBuilder(
          future: future,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Shimmer.fromColors(
                baseColor: Colors.grey[500]!,
                highlightColor: Colors.grey[100]!,
                child: SingleChildScrollView(
                  child: Column(
                    children: List.generate(
                      100,
                      (index) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Container(
                          width: double.infinity,
                          height: 20.0,
                          color: Colors.grey[100]!,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            } else if (snapshot.hasData) {
              return SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ..._queryAnswer(snapshot.data!).map(
                      (e) => ListTile(
                        leading: Icon(
                          Symbols.package_2,
                          color: Colors.blue.withOpacity(0.80),
                          size: 30,
                        ),
                        title: Text(e.title),
                        subtitle: Text(e.description),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return const Center(child: Text('Không hỏi được Gemini'));
            }
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  List<_QueriedAnswer> _queryAnswer(String text) {
    final regExp = RegExp(r'\*\*\*(.*?)\*\*|\*\*(.*?)\*\*');
    final List<_QueriedAnswer> structuredContent = [];
    var matches = regExp.allMatches(text);
    for (var match in matches) {
      var title = match.group(1) ?? match.group(2) ?? '';
      var start = match.end;
      var end = text.indexOf(RegExp(r'\*\*\*|\*\*'), start);
      if (end == -1) end = text.length;
      var description = text.substring(start, end).trim();
      if (description == '*') continue;
      if (description.endsWith('*')) {
        description = description.substring(0, description.length - 1);
      }
      structuredContent.add(
        _QueriedAnswer(title: title.trim(), description: description),
      );
    }
    return structuredContent;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          product.productName!,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 0.5,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProductProfile(product: product),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Thông số sản phẩm',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ),
                onPressed: () async {
                  await showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Thông số sản phẩm'),
                      content: ProductSpecificationPage(product: product),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _askGemini(context, ref),
        child: const Icon(Symbols.magic_button),
      ),
      bottomNavigationBar: BottomAppBar(child: ProductNavbar(product: product)),
    );
  }
}

class _QueriedAnswer {
  final String title;
  final String description;

  _QueriedAnswer({
    required this.title,
    required this.description,
  });
}
