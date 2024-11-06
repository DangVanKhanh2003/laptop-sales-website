import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:shopping_app/model/category.dart';
import 'package:shopping_app/model/product.dart';
import 'package:shopping_app/repository/product_repository.dart';
import 'package:shopping_app/screen/exception/exception_page.dart';
import 'package:shopping_app/screen/product_detail/product_detail.dart';
import 'package:shopping_app/service/getit.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({
    super.key,
    required this.category,
  });

  final Category category;

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  late Future<ProductList> _future;

  @override
  void initState() {
    super.initState();
    _future = GetItWrapper.getIt<ProductRepository>().getProductByCategoryId(
      categoryId: widget.category.categoryId!,
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
            return const Center(child: CircularProgressIndicator.adaptive());
          } else if (snapshot.hasError) {
            return Center(
              child: ExceptionPage(
                message: snapshot.error.toString(),
              ),
            );
          } else if (snapshot.hasData) {
            final data = (snapshot.data as ProductList).productList!;
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 4.0,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ...data.map(
                      (e) => Container(
                        margin: const EdgeInsets.symmetric(
                          vertical: 8.0,
                          horizontal: 4.0,
                        ),
                        child: Card(
                          clipBehavior: Clip.hardEdge,
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(8.0),
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => ProductDetail(
                                    product: e,
                                  ),
                                ),
                              );
                            },
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: CachedNetworkImage(
                                imageUrl: e.mainImg ??
                                    'http://via.placeholder.com/350x150',
                                placeholder: (context, url) =>
                                    const CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                            ),
                            title: Text(
                              e.productName!,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            subtitle: Text(
                              '\$${e.price!}',
                              style: const TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            trailing: IconButton(
                              icon: const Icon(Symbols.favorite_border),
                              onPressed: () {
                                // TODO: Làm nút yêu thích
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
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
