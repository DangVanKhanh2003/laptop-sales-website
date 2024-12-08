import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:shopping_app/screen/account_detail/account_detail.dart';
import 'package:shopping_app/screen/setting/change_password/change_password.dart';
import 'package:shopping_app/screen/setting/privacy_policy.dart';

class AccountSetting extends StatefulWidget {
  const AccountSetting({super.key});

  @override
  State<AccountSetting> createState() => _AccountSettingState();
}

class _AccountSettingState extends State<AccountSetting> {
  void _onPrivacyPolicy() async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: const PrivacyPolicy(),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _changePassword() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const ChangePassword(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            contentPadding: const EdgeInsets.all(8.0),
            title: const Text('Đổi mật khẩu'),
            leading: const Icon(Symbols.password_2),
            onTap: _changePassword,
          ),
          ListTile(
            contentPadding: const EdgeInsets.all(8.0),
            title: const Text('Xem tài khoản'),
            leading: const Icon(Symbols.person_2),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const AccountDetail(),
                ),
              );
            },
          ),
          ListTile(
            contentPadding: const EdgeInsets.all(8.0),
            title: const Text('Chính sách bảo mật'),
            leading: const Icon(Symbols.security),
            onTap: _onPrivacyPolicy,
          ),
        ],
      ),
    );
  }
}
