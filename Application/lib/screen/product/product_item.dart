import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/model/product.dart';
import 'package:shopping_app/service/convert_helper.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    super.key,
    required this.product,
    required this.onTap,
  });

  final Product product;

  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              product.mainImg != null
                  ? Image(
                      image: MemoryImage(
                        ConvertHelper.decodeBase64(data: product.mainImg!),
                      ),
                      width: 350,
                      height: 100,
                    )
                  : CachedNetworkImage(
                      imageUrl: 'http://via.placeholder.com/350x100',
                      fit: BoxFit.cover,
                    ),
              const SizedBox(height: 15.0),
              Text(
                product.productName!,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 2.0),
              Text('\$${product.price!}'),
            ],
          ),
        ),
      ),
    );
  }
}
