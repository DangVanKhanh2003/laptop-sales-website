import 'package:flutter/material.dart';
import 'package:shopping_app/view/home/home_page.dart';
import 'package:shopping_app/view/notification/notification_page.dart';
import 'package:shopping_app/view/setting/setting_page.dart';

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
        title: const Text('Shop'),
      ),
      body: _screens[_index],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Trang chủ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_outlined),
            label: 'Thông báo',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
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
