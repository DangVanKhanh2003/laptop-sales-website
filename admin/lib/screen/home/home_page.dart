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

  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

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
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue, Colors.lightBlueAccent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10.0,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.account_circle,
                      size: 50,
                      color: Colors.white,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Admin',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            _buildMenuItem('Trang chủ', 0),
            _buildMenuItem('Thống kê', 1),
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
