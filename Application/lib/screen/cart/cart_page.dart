import 'package:flutter/material.dart';
import 'package:shopping_app/screen/cart/empty_cart.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Giỏ hàng của tôi'),
      ),
      body: const EmptyCart(),
    );
  }
}
