import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/application.dart';
import 'package:shopping_app/provider/setting_provider.dart';
import 'package:window_manager/window_manager.dart';

Future<void> main(
  List<String> arguments,
) async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    await WindowManager.instance.ensureInitialized();
    await windowManager.center();
    await windowManager.waitUntilReadyToShow();
    await windowManager.show();
  }
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => SettingProvider(),
      ),
    ],
    child: const Application(),
  ));
}
