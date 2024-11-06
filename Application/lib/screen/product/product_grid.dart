import 'package:flutter/material.dart';
import 'package:shopping_app/model/product.dart';
import 'package:shopping_app/screen/product/product_item.dart';
import 'package:shopping_app/screen/product_detail/product_detail.dart';

class ProductGrid extends StatelessWidget {
  const ProductGrid({
    super.key,
    required this.products,
  });

  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      children: List.generate(
        products.length,
        (index) => Hero(
          tag: products[index].productId!,
          child: ProductItem(
            product: products[index],
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ProductDetail(
                    product: products[index],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
