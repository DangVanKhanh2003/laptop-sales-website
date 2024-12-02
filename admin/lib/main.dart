import 'package:admin/application.dart';
import 'package:admin/service/getit_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main(
  List<String> arguments,
) async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  GetItHelper.registerSingleton();
  runApp(const Application());
}
