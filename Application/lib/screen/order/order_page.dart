import 'package:flutter/material.dart';
import 'package:shopping_app/screen/order/order_empty.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Đơn hàng'),
      ),
      body: const OrderEmpty(),
    );
  }
}
