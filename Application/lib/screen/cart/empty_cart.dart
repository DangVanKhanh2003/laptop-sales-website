import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class EmptyCart extends StatelessWidget {
  const EmptyCart({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(
            Symbols.shopping_cart,
            size: 50,
            color: Colors.blueAccent,
          ),
          const SizedBox(height: 20),
          const Text('Bạn chưa có sản phẩm nào trong giỏ hàng'),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Mua hàng ngay'),
            ),
          ),
        ],
      ),
    );
  }
}
