import 'package:admin/screen/home/home_page.dart';
import 'package:admin/screen/login/login_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Admin',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: kDebugMode ? const HomePage() : const LoginPage(),
    );
  }
}
