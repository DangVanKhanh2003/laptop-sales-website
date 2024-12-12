import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
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

  late PageStorageBucket _bucket;

  final List<Widget> _screens = const <Widget>[
    HomePage(
      key: PageStorageKey('home'),
    ),
    NotificationPage(
      key: PageStorageKey('notification'),
    ),
    SettingPage(
      key: PageStorageKey('setting'),
    ),
  ];

  @override
  void initState() {
    _index = 0;
    _bucket = PageStorageBucket();
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
      body: PageStorage(
        bucket: _bucket,
        child: IndexedStack(
          index: _index,
          children: _screens,
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor:
            Theme.of(context).brightness == Brightness.dark ? Colors.black : Theme.of(context).colorScheme.surface,
        color: Theme.of(context).brightness == Brightness.dark ? Colors.blueGrey : Colors.blueAccent,
        items: [
          CurvedNavigationBarItem(
            child: Icon(Symbols.home, color: Colors.white),
            label: 'Trang chủ',
            labelStyle: TextStyle(color: Colors.white),
          ),
          CurvedNavigationBarItem(
            child: Icon(Symbols.notifications, color: Colors.white),
            label: 'Thông báo',
            labelStyle: TextStyle(color: Colors.white),
          ),
          CurvedNavigationBarItem(
            child: Icon(Symbols.settings, color: Colors.white),
            label: 'Cài đặt',
            labelStyle: TextStyle(color: Colors.white),
          ),
        ],
        index: _index,
        onTap: _onChangeScreen,
      ),
    );
  }
}
