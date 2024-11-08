import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class HistoryEmpty extends StatelessWidget {
  const HistoryEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(Symbols.package_2, size: 50, color: Colors.amber),
          const SizedBox(height: 15.0),
          const Text(
            'Lịch sử mua hàng của bạn trống, bạn chưa mua bất kì mặt hàng nào!',
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
