import 'package:flutter/material.dart';
import 'package:shopping_app/model/product.dart';
import 'package:shopping_app/repository/product_repository.dart';
import 'package:shopping_app/screen/exception/exception_page.dart';
import 'package:shopping_app/service/getit.dart';

class ProductSpecificationPage extends StatefulWidget {
  const ProductSpecificationPage({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  State<ProductSpecificationPage> createState() =>
      _ProductSpecificationPageState();
}

class _ProductSpecificationPageState extends State<ProductSpecificationPage> {
  late Future<ProductSpecificationList> _future;

  @override
  void initState() {
    super.initState();
    _future = GetItWrapper.getIt<ProductRepository>().getProductSpecification(
      id: widget.product.productId!,
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator.adaptive();
        } else if (snapshot.hasData) {
          final data = snapshot.data!.productSpecificationList!;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: data
                    .map(
                      (e) => Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              e.specType!,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blueGrey[800],
                                  ),
                            ),
                            const SizedBox(height: 4.0),
                            Text(
                              e.description!,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    color: Colors.grey[700],
                                  ),
                            ),
                            const Divider(thickness: 1, height: 20),
                          ],
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return ExceptionPage(message: snapshot.error.toString());
        } else {
          return const Center(
            child: Text('Không thể fetch được sản phẩm'),
          );
        }
      },
    );
  }
}
