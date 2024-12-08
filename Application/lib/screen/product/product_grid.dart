import 'package:flutter/material.dart';
import 'package:shopping_app/model/product.dart';
import 'package:shopping_app/screen/product/product_item.dart';
import 'package:shopping_app/screen/product_detail/product_detail.dart';

class ProductGrid extends StatelessWidget {
  const ProductGrid({
    super.key,
    required this.products,
    this.controller,
  });

  final List<Product> products;

  final ScrollController? controller;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      controller: controller,
      crossAxisCount: 2,
      children: List.generate(
        products.length,
        (index) => ProductItem(
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
    );
  }
}
