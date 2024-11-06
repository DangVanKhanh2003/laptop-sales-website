import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class AccountSetting extends StatefulWidget {
  const AccountSetting({super.key});

  @override
  State<AccountSetting> createState() => _AccountSettingState();
}

class _AccountSettingState extends State<AccountSetting> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            contentPadding: const EdgeInsets.all(8.0),
            title: const Text('Đổi mật khẩu'),
            leading: const Icon(Symbols.password_2),
            onTap: () {},
          ),
          ListTile(
            contentPadding: const EdgeInsets.all(8.0),
            title: const Text('Xem tài khoản'),
            leading: const Icon(Symbols.person_2),
            onTap: () {},
          ),
          ListTile(
            contentPadding: const EdgeInsets.all(8.0),
            title: const Text('Chính sách bảo mật'),
            leading: const Icon(Symbols.security),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
