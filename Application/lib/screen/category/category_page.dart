import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_app/model/category.dart';
import 'package:shopping_app/model/product.dart';
import 'package:shopping_app/provider/token_provider.dart';
import 'package:shopping_app/repository/product_repository.dart';
import 'package:shopping_app/screen/category/category_loading.dart';
import 'package:shopping_app/screen/category/product_card.dart';
import 'package:shopping_app/screen/exception/exception_page.dart';
import 'package:shopping_app/service/getit_helper.dart';

class CategoryPage extends ConsumerStatefulWidget {
  const CategoryPage({
    super.key,
    required this.category,
  });

  final Category category;

  @override
  ConsumerState<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends ConsumerState<CategoryPage> {
  late Future<ProductList> _future;

  @override
  void initState() {
    super.initState();
    _future = GetItHelper.get<ProductRepository>().getProductByCategoryId(
      categoryId: widget.category.categoryId!,
      token: ref.read(tokenProvider),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category.categoryName!),
        elevation: 0,
      ),
      body: FutureBuilder(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CategoryLoading();
          } else if (snapshot.hasError) {
            return Center(
              child: ExceptionPage(
                message: snapshot.error.toString(),
              ),
            );
          } else if (snapshot.hasData) {
            final data = (snapshot.data as ProductList).productList!;
            return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: CustomScrollView(
                slivers: [
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => ProductCard(product: data[index]),
                      childCount: data.length,
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
