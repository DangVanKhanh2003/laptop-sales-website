import 'package:admin/screen/category/manage_category.dart';
import 'package:admin/screen/dashboard/dashboard_page.dart';
import 'package:admin/screen/home/regular_home.dart';
import 'package:admin/screen/order/manage_order.dart';
import 'package:admin/screen/order_pending/manage_order_pending.dart';
import 'package:admin/screen/product/manage_product.dart';
import 'package:admin/screen/user/manage_user.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildMenuItem(
    String title,
    int index,
  ) {
    return ListTile(
      title: Text(title),
      selected: _selectedIndex == index,
      onTap: () {
        _onItemTapped(index);
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Panel'),
      ),
      body: <Widget>[
        const RegularHome(),
        const DashboardPage(),
        const ManageCategory(),
        const ManageProduct(),
        const ManageUser(),
        const ManageOrder(),
        const ManageOrderPending(),
      ][_selectedIndex],
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            _buildMenuItem('Trang chủ', 0),
            _buildMenuItem('Dashboard', 1),
            _buildMenuItem('Danh mục', 2),
            _buildMenuItem('Sản phẩm', 3),
            _buildMenuItem('Người dùng', 4),
            _buildMenuItem('Đơn hàng', 5),
            _buildMenuItem('Đơn hàng cần duyệt', 6),
          ],
        ),
      ),
    );
  }
}
