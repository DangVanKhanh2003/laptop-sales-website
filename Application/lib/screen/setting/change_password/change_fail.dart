import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shopping_app/screen/root/root_screen.dart';

class ChangeFail extends StatelessWidget {
  const ChangeFail({
    super.key,
    required this.error,
  });

  final String error;

  void _toMainPage(BuildContext context) {
    Navigator.of(context).pushReplacement(
      PageTransition(
        child: const RootScreen(),
        type: PageTransitionType.fade,
        duration: const Duration(milliseconds: 500),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Đổi mật khẩu thất bại'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Symbols.info,
              size: 50,
              color: Colors.red,
            ),
            const SizedBox(height: 15.0),
            const Text('Đổi mật khẩu thất bại'),
            const SizedBox(height: 8.0),
            Text('Lỗi xảy ra: $error'),
            const SizedBox(height: 20.0),
            TextButton(
              style: ButtonStyle(
                shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ),
              child: const Text('Về trang chủ'),
              onPressed: () {
                _toMainPage(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
