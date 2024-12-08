import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shopping_app/screen/cart/cart_page.dart';
import 'package:shopping_app/screen/home/home_page.dart';
import 'package:shopping_app/screen/message/message_page.dart';
import 'package:shopping_app/screen/notification/notification_page.dart';
import 'package:shopping_app/screen/setting/setting_page.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  late int _index;

  final List<Widget> _screens = const <Widget>[
    HomePage(),
    NotificationPage(),
    SettingPage(),
  ];

  @override
  void initState() {
    _index = 0;
    super.initState();
  }

  void _onChangeScreen(int index) {
    setState(() {
      _index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Commercial Project'),
        actions: [
          Tooltip(
            message: 'Giỏ hàng',
            child: IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  PageTransition(
                    type: PageTransitionType.rightToLeft,
                    duration: const Duration(milliseconds: 200),
                    child: const CartPage(),
                  ),
                );
              },
              icon: const Icon(Symbols.shopping_cart),
            ),
          ),
          Tooltip(
            message: 'Tin nhắn',
            child: IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const MessagePage(),
                  ),
                );
              },
              icon: const Icon(Symbols.message),
            ),
          ),
        ],
      ),
      body: _screens[_index],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Symbols.home),
            label: 'Trang chủ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Symbols.notifications),
            label: 'Thông báo',
          ),
          BottomNavigationBarItem(
            icon: Icon(Symbols.settings),
            label: 'Cài đặt',
          ),
        ],
        currentIndex: _index,
        selectedItemColor:
            Theme.of(context).colorScheme.primary.withOpacity(0.85),
        onTap: _onChangeScreen,
      ),
    );
  }
}
