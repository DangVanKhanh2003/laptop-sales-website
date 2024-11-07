import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shopping_app/screen/login/login_page.dart';

class ChangeSuccess extends StatelessWidget {
  const ChangeSuccess({super.key});

  void _toLoginScreen(BuildContext context) {
    Navigator.of(context).pushReplacement(
      PageTransition(
        child: const LoginPage(),
        type: PageTransitionType.fade,
        duration: const Duration(milliseconds: 500),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Đổi mật khẩu thành công'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Symbols.done,
              size: 50,
              color: Colors.green,
            ),
            const SizedBox(height: 15.0),
            const Text('Đổi mật khẩu thành công'),
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
              child: const Text('Về đăng nhập'),
              onPressed: () {
                _toLoginScreen(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
