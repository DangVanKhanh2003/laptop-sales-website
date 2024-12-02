import 'package:delightful_toast/delight_toast.dart';
import 'package:delightful_toast/toast/components/toast_card.dart';
import 'package:flutter/material.dart';

class ToastHelper {
  static void showToast({
    required BuildContext context,
    required String message,
    Color? color,
  }) {
    DelightToastBar(
      autoDismiss: true,
      snackbarDuration: const Duration(seconds: 2),
      builder: (context) => ToastCard(
        leading: const Icon(
          Icons.notification_add_outlined,
          size: 28,
        ),
        title: Text(
          message,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 14,
          ),
        ),
        color: color,
      ),
    ).show(context);
  }
}
