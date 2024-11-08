import 'package:flutter/material.dart';
import 'package:shopping_app/screen/history/history_empty.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lịch sử mua hàng'),
      ),
      body: const HistoryEmpty(),
    );
  }
}
