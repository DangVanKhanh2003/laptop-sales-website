import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_app/model/order.dart';
import 'package:shopping_app/provider/token_provider.dart';
import 'package:shopping_app/repository/order_repository.dart';
import 'package:shopping_app/screen/exception/exception_page.dart';
import 'package:shopping_app/screen/order/order_empty.dart';
import 'package:shopping_app/screen/order/order_list.dart';
import 'package:shopping_app/service/getit_helper.dart';

class OrderPage extends ConsumerStatefulWidget {
  const OrderPage({super.key});

  @override
  ConsumerState<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends ConsumerState<OrderPage> {
  late Future<List<Order>> _future;

  @override
  void initState() {
    _future = GetItHelper.get<OrderRepository>().getAllOrders(
      token: ref.read(tokenProvider),
      customerId: ref.read(tokenProvider.notifier).customerId,
    );
    super.initState();
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
        title: const Text('Đơn hàng'),
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
              child: OrderList(data: data),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
