import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:shopping_app/model/order_pending.dart';
import 'package:shopping_app/provider/token_provider.dart';
import 'package:shopping_app/repository/order_pending_repository.dart';
import 'package:shopping_app/screen/exception/exception_page.dart';
import 'package:shopping_app/screen/root/root_screen.dart';
import 'package:shopping_app/service/getit_helper.dart';

class FinishPayment extends ConsumerStatefulWidget {
  const FinishPayment({
    super.key,
    required this.list,
  });

  final List<ListProductOrederPending> list;

  @override
  ConsumerState<FinishPayment> createState() => _FinishPaymentState();
}

class _FinishPaymentState extends ConsumerState<FinishPayment> {
  late Future<void> _future;

  @override
  void initState() {
    _future = GetItHelper.get<OrderPendingRepository>().addOrderPending(
      token: ref.read(tokenProvider),
      order: OrderPending(
        customerId: ref.read(tokenProvider.notifier).customerId,
        listProductOrederPending: widget.list,
      ),
    );
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Đặt hàng hoàn tất'),
      ),
      body: FutureBuilder(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: ExceptionPage(message: snapshot.error.toString()),
            );
          } else if (snapshot.hasData) {
            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Symbols.order_approve,
                    color: Colors.green,
                    size: 50.0,
                  ),
                  const SizedBox(height: 20.0),
                  Text(
                    'Đặt hàng hoàn tất!',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 10.0),
                  ElevatedButton(
                    onPressed: () {
                      while (Navigator.of(context).canPop()) {
                        Navigator.of(context).pop();
                      }
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => RootScreen(),
                        ),
                      );
                    },
                    child: Text('Về trang chủ'),
                  ),
                ],
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
