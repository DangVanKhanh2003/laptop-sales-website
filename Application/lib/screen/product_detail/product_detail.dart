import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/model/product.dart';
import 'package:shopping_app/screen/product_detail/product_navbar.dart';
import 'package:shopping_app/screen/product_detail/product_specification.dart';

class ProductDetail extends StatelessWidget {
  const ProductDetail({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          product.productName!,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 0.5,
      ),
      body: Hero(
        tag: product.productId!,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CachedNetworkImage(
                imageUrl:
                    product.mainImg ?? 'http://via.placeholder.com/500x150',
                fit: BoxFit.cover,
                height: 300,
                width: double.infinity,
                placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      product.productName!,
                      style:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'Hãng: ${product.brand!}',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(color: Colors.grey[600]),
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      '\$${product.price!}',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 24.0),
                    ElevatedButton(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Thông số sản phẩm',
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
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
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 8.0),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: ProductNavbar(
          product: product,
        ),
      ),
    );
  }
}
