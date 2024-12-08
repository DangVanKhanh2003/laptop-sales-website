import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:shopping_app/provider/setting_provider.dart';

class ApplicationSetting extends ConsumerStatefulWidget {
  const ApplicationSetting({super.key});

  @override
  ConsumerState<ApplicationSetting> createState() => _ApplicationSettingState();
}

class _ApplicationSettingState extends ConsumerState<ApplicationSetting> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _onChangeThemeNotifier(String? newValue) {
    if (newValue == null) return;
    ref.read(settingProvider.notifier).setTheme(newValue);
  }

  void _onChangeTheme() async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Chế độ'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('Hệ thống'),
              leading: Radio(
                value: 'system',
                groupValue: ref.watch(settingProvider).theme,
                onChanged: _onChangeThemeNotifier,
              ),
            ),
            ListTile(
              title: const Text('Tối'),
              leading: Radio(
                value: 'dark',
                groupValue: ref.watch(settingProvider).theme,
                onChanged: _onChangeThemeNotifier,
              ),
            ),
            ListTile(
              title: const Text('Sáng'),
              leading: Radio(
                value: 'light',
                groupValue: ref.watch(settingProvider).theme,
                onChanged: _onChangeThemeNotifier,
              ),
            ),
          ],
        ),
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

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            contentPadding: const EdgeInsets.all(8.0),
            leading: const Icon(Symbols.dark_mode),
            title: const Text('Chế độ'),
            onTap: _onChangeTheme,
          ),
          const ListTile(
            contentPadding: EdgeInsets.all(8.0),
            leading: Icon(Symbols.translate),
            title: Text('Ngôn ngữ'),
            subtitle: Text('Tiếng Việt'),
          ),
          ListTile(
            contentPadding: const EdgeInsets.all(8.0),
            leading: const Icon(Symbols.notifications),
            title: const Text('Bật thông báo'),
            trailing: Checkbox(
              value: ref.watch(settingProvider).sendNotification,
              onChanged: (bool? newValue) {
                if (newValue == null) return;
                ref
                    .watch(settingProvider.notifier)
                    .setSendNotification(newValue);
              },
            ),
          ),
          ListTile(
            contentPadding: const EdgeInsets.all(8.0),
            leading: const Icon(Symbols.gps_fixed),
            title: const Text('Sử dụng định vị'),
            trailing: Checkbox(
              value: ref.watch(settingProvider).allowLocation,
              onChanged: (bool? newValue) {
                if (newValue == null) return;
                ref.watch(settingProvider.notifier).setAllowLocation(newValue);
              },
            ),
          ),
        ],
      ),
    );
  }
}
