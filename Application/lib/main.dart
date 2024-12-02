import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_app/application.dart';
import 'package:shopping_app/service/getit_helper.dart';
import 'package:shopping_app/service/notification_helper.dart';
import 'package:window_manager/window_manager.dart';

Future<void> main(
  List<String> arguments,
) async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    await WindowManager.instance.ensureInitialized();
    await windowManager.setMinimumSize(Size(400, 1000));
    await windowManager.setMaximumSize(Size(600, 1000));
    await windowManager.center();
    await windowManager.waitUntilReadyToShow();
    await windowManager.show();
  }
  GetItHelper.registerSingleton();
  await NotificationHelper.initialize();
  runApp(
    const ProviderScope(
      child: Application(),
    ),
  );
}
