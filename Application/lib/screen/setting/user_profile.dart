import 'package:flutter/material.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({
    super.key,
    required this.onDetail,
    required this.onLogout,
  });

  final void Function() onDetail;

  final void Function() onLogout;

  void _onSelected(String item) {
    switch (item) {
      case 'detail':
        onDetail();
        break;
      case 'logout':
        onLogout();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.all(16.0),
        leading: Image.asset(
          'assets/images/user.png',
          width: 40,
          height: 40,
          fit: BoxFit.cover,
        ),
        title: const Text('Khách hàng'),
        subtitle: const Text('Đã đăng nhập'),
        trailing: PopupMenuButton<String>(
          onSelected: _onSelected,
          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
            const PopupMenuItem<String>(
              value: 'detail',
              child: Text('Xem chi tiết'),
            ),
            const PopupMenuItem<String>(
              value: 'logout',
              child: Text('Đăng xuất'),
            ),
          ],
        ),
      ),
    );
  }
}
