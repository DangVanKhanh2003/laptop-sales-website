import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class EmptyPage extends StatelessWidget {
  const EmptyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Symbols.error,
            size: 50.0,
            color: Colors.red,
          ),
          const SizedBox(height: 8.0),
          const Text('Không tìm thấy bất kì sản phẩm nào'),
          const SizedBox(height: 8.0),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Quay lại'),
          ),
        ],
      ),
    );
  }
}
