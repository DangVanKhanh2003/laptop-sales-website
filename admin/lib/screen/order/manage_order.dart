import 'package:admin/screen/order/order_cancel.dart';
import 'package:admin/screen/order/order_pending.dart';
import 'package:admin/screen/order/order_success.dart';
import 'package:flutter/material.dart';

class ManageOrder extends StatelessWidget {
  const ManageOrder({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(
                icon: Icon(
                  Icons.pending,
                  color: Colors.cyan,
                ),
                text: 'Chờ duyệt',
              ),
              Tab(
                icon: Icon(
                  Icons.done,
                  color: Colors.green,
                ),
                text: 'Hoàn tất',
              ),
              Tab(
                icon: Icon(
                  Icons.cancel,
                  color: Colors.red,
                ),
                text: 'Đã hủy',
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            OrderPending(),
            OrderSuccess(),
            OrderCancel(),
          ],
        ),
      ),
    );
  }
}
