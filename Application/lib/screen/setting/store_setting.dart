import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:shopping_app/screen/cart/cart_page.dart';
import 'package:shopping_app/screen/history/history_page.dart';
import 'package:shopping_app/screen/order/order_page.dart';
import 'package:shopping_app/screen/order_pending/order_pending_page.dart';

class StoreSetting extends StatefulWidget {
  const StoreSetting({super.key});

  @override
  State<StoreSetting> createState() => _StoreSettingState();
}

class _StoreSettingState extends State<StoreSetting> {
  Widget _iconButton({
    required void Function() onPressed,
    required IconData icon,
    required String name,
  }) {
    return InkWell(
      onTap: onPressed,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Icon(icon),
              const SizedBox(height: 16.0),
              Text(name),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _iconButton(
              icon: Symbols.shopping_cart,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const CartPage(),
                  ),
                );
              },
              name: 'Giỏ Hàng',
            ),
            const SizedBox(width: 12.0),
            _iconButton(
              icon: Symbols.pending,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const OrderPendingPage(),
                  ),
                );
              },
              name: 'Đơn Hàng chờ duyệt',
            ),
            const SizedBox(width: 12.0),
            _iconButton(
              icon: Symbols.shopping_bag,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const OrderPage(),
                  ),
                );
              },
              name: 'Đơn hàng đã duyệt',
            ),
            const SizedBox(width: 12.0),
            _iconButton(
              icon: Symbols.history,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const HistoryPage(),
                  ),
                );
              },
              name: 'Lịch sử mua hàng',
            ),
            const SizedBox(width: 12.0),
          ],
        ),
      ),
    );
  }
}
