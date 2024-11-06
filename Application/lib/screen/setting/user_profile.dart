import 'package:flutter/material.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

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
      ),
    );
  }
}
