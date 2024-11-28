import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/model/product.dart';
import 'package:shopping_app/service/convert_helper.dart';

class ProductProfile extends StatelessWidget {
  final Product product;

  const ProductProfile({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        product.mainImg != null
            ? Image(
                image: MemoryImage(
                  ConvertHelper.decodeBase64(data: product.mainImg!),
                ),
                fit: BoxFit.cover,
                height: 300,
                width: double.infinity,
              )
            : CachedNetworkImage(
                imageUrl: 'http://via.placeholder.com/500x150',
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
            children: [
              Text(
                product.productName!,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
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
            ],
          ),
        ),
      ],
    );
  }
}
