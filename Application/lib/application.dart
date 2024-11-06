import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_app/model/theme.dart';
import 'package:shopping_app/provider/theme_provider.dart';
import 'package:shopping_app/screen/root/root_screen.dart';
import 'package:dynamic_color/dynamic_color.dart';

class Application extends ConsumerWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DynamicColorBuilder(
      builder: (lightDynamic, darkDynamic) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Shopping App',
        theme: MaterialDesign.lightTheme.copyWith(
          colorScheme: lightDynamic,
        ),
        darkTheme: MaterialDesign.darkTheme.copyWith(
          colorScheme: darkDynamic,
        ),
        themeMode: ref.watch(themeProvider),
        home: const RootScreen(),
      ),
    );
  }
}
