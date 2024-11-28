// product_detail.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_app/model/product.dart';
import 'package:shopping_app/screen/product_detail/product_navbar.dart';
import 'package:shopping_app/screen/product_detail/product_profile.dart';
import 'package:shopping_app/screen/product_detail/product_specification.dart';

class ProductDetail extends ConsumerStatefulWidget {
  const ProductDetail({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  ConsumerState<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends ConsumerState<ProductDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.product.productName!,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 0.5,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProductProfile(product: widget.product),
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
                      content:
                          ProductSpecificationPage(product: widget.product),
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
      bottomNavigationBar:
          BottomAppBar(child: ProductNavbar(product: widget.product)),
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
