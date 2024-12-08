import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:shopping_app/screen/history/history_approve.dart';
import 'package:shopping_app/screen/history/history_cancel.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Lịch sử mua hàng'),
          bottom: TabBar(
            tabs: [
              Tab(
                icon: Icon(Symbols.order_approve),
              ),
              Tab(
                icon: Icon(Symbols.order_play),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            HistoryApprove(),
            HistoryCancel(),
          ],
        ),
      ),
    );
  }
}
