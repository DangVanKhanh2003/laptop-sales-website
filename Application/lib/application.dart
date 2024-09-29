import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/model/theme.dart';
import 'package:shopping_app/provider/setting_provider.dart';
import 'package:shopping_app/view/login/login_page.dart';
import 'package:shopping_app/view/root/root_screen.dart';

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS || Platform.isMacOS) {
      return const CupertinoApp(
        debugShowCheckedModeBanner: false,
        title: 'Shopping App',
        theme: CupertinoDesign.lightTheme,
        home: LoginPage(),
      );
    } else {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Shopping App',
        theme: MaterialDesign.lightTheme,
        darkTheme: MaterialDesign.darkTheme,
        themeMode: Provider.of<SettingProvider>(context).themeData,
        home: const RootScreen(),
      );
    }
  }
}
