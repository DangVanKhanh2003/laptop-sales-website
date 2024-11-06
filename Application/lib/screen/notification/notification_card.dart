import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard({
    super.key,
    required this.title,
    required this.message,
  });

  final String title;

  final String message;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Symbols.notification_add),
        title: Text(title),
        subtitle: Text(message),
      ),
    );
  }
}
