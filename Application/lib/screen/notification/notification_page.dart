import 'package:flutter/material.dart';
import 'package:shopping_app/screen/notification/notification_card.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            NotificationCard(
              title: 'Đăng ký thành công',
              message: 'Bạn đã đăng ký tài khoản thành công',
            ),
          ],
        ),
      ),
    );
  }
}
