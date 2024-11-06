import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class ApplicationSetting extends StatefulWidget {
  const ApplicationSetting({super.key});

  @override
  State<ApplicationSetting> createState() => _ApplicationSettingState();
}

class _ApplicationSettingState extends State<ApplicationSetting> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            contentPadding: const EdgeInsets.all(8.0),
            leading: const Icon(Symbols.dark_mode),
            title: const Text('Chế độ'),
            onTap: () {},
          ),
          ListTile(
            contentPadding: const EdgeInsets.all(8.0),
            leading: const Icon(Symbols.translate),
            title: const Text('Ngôn ngữ'),
            subtitle: const Text('Tiếng Việt'),
            onTap: () {},
          ),
          ListTile(
            contentPadding: const EdgeInsets.all(8.0),
            leading: const Icon(Symbols.notifications),
            title: const Text('Bật thông báo'),
            trailing: Checkbox(value: true, onChanged: (bool? newValue) {}),
          ),
          ListTile(
            contentPadding: const EdgeInsets.all(8.0),
            leading: const Icon(Symbols.gps_fixed),
            title: const Text('Sử dụng định vị'),
            trailing: Checkbox(value: true, onChanged: (bool? newValue) {}),
          ),
        ],
      ),
    );
  }
}
