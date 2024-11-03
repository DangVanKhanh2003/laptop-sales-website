import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:shopping_app/model/product.dart';

class ProductNavbar extends StatelessWidget {
  final Product product;

  const ProductNavbar({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        IconButton(
          tooltip: 'Chat với người bán',
          icon: const Icon(Symbols.message),
          onPressed: () {
            // TODO:
          },
        ),
        const SizedBox(width: 12),
        IconButton(
          tooltip: 'Thêm vào giỏ hàng',
          icon: const Icon(Symbols.shopping_cart),
          onPressed: () {
            // TODO:
          },
        ),
        const SizedBox(width: 12),
        Expanded(
          flex: 2,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
            ),
            onPressed: () {
              // TODO:
            },
            child: Column(
              children: [
                const Text(
                  'Mua ngay',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  '\$${product.price!}',
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
