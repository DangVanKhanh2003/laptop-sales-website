import 'package:flutter/material.dart';

class ExceptionPage extends StatelessWidget {
  const ExceptionPage({
    super.key,
    required this.message,
    this.onTap,
  });

  final String message;

  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Icon(
          Icons.flutter_dash_outlined,
          color: Colors.blue,
          size: 50,
        ),
        const SizedBox(height: 15),
        const Icon(Icons.info_outline, color: Colors.red),
        const SizedBox(height: 15),
        Text(
          message,
          textAlign: TextAlign.center,
        ),
        onTap == null
            ? const SizedBox.shrink()
            : TextButton(
                onPressed: onTap,
                child: const Text('Thử lại'),
              ),
      ],
    );
  }
}
