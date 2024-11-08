import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class OrderEmpty extends StatelessWidget {
  const OrderEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(Symbols.order_approve, size: 50, color: Colors.green),
          const SizedBox(height: 15.0),
          const Text(
            'Bạn chưa có bất kì đơn hàng nào!',
          ),
          const SizedBox(height: 15.0),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              child: Text('Quay lại'),
            ),
          ),
        ],
      ),
    );
  }
}
