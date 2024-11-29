import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_app/model/order_pending.dart';
import 'package:shopping_app/provider/token_provider.dart';
import 'package:shopping_app/repository/order_pending_repository.dart';
import 'package:shopping_app/screen/exception/exception_page.dart';
import 'package:shopping_app/screen/order_pending/order_empty.dart';
import 'package:shopping_app/screen/order_pending/order_list.dart';
import 'package:shopping_app/service/getit_helper.dart';

class OrderPendingPage extends ConsumerStatefulWidget {
  const OrderPendingPage({super.key});

  @override
  ConsumerState<OrderPendingPage> createState() => _OrderPendingPageState();
}

class _OrderPendingPageState extends ConsumerState<OrderPendingPage> {
  late Future<List<OrderPending>> _future;

  @override
  void initState() {
    _refreshFuture();
    super.initState();
  }

  void _refreshFuture() {
    _future = GetItHelper.get<OrderPendingRepository>().getAllOrderPending(
      token: ref.read(tokenProvider),
      status: 'pending',
    );
  }

  void _onRefreshFuture() {
    _refreshFuture();
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Đơn hàng chờ duyệt'),
      ),
      body: FutureBuilder(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator.adaptive());
          } else if (snapshot.hasError) {
            return Center(
              child: ExceptionPage(
                message: snapshot.error.toString(),
              ),
            );
          } else if (snapshot.hasData) {
            final data = snapshot.data!;
            if (data.isEmpty) {
              return OrderEmpty();
            }
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: OrderList(
                data: data,
                onRefreshFuture: _onRefreshFuture,
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
