import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_app/provider/token_provider.dart';
import 'package:shopping_app/screen/account_detail/account_detail.dart';
import 'package:shopping_app/screen/login/login_page.dart';
import 'package:shopping_app/screen/setting/account_setting.dart';
import 'package:shopping_app/screen/setting/application_setting.dart';
import 'package:shopping_app/screen/setting/store_setting.dart';
import 'package:shopping_app/screen/setting/user_profile.dart';

class SettingPage extends ConsumerStatefulWidget {
  const SettingPage({super.key});

  @override
  ConsumerState<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends ConsumerState<SettingPage> {
  void _onLogout() async {
    await ref.watch(tokenProvider.notifier).clearToken();
    _navigateLogin();
  }

  void _navigateLogin() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const LoginPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            UserProfile(
              onLogout: _onLogout,
              onDetail: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const AccountDetail(),
                  ),
                );
              },
            ),
            const SizedBox(height: 4.0),
            const Divider(thickness: 1.0, color: Colors.grey),
            const SizedBox(height: 4.0),
            const StoreSetting(),
            const SizedBox(height: 4.0),
            const Divider(thickness: 1.0, color: Colors.grey),
            const SizedBox(height: 4.0),
            const ApplicationSetting(),
            const SizedBox(height: 4.0),
            const Divider(thickness: 1.0, color: Colors.grey),
            const SizedBox(height: 4.0),
            const AccountSetting(),
            const SizedBox(height: 16.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              onPressed: _onLogout,
              child: const SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Center(
                      child: Text(
                    'Đăng xuất',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
