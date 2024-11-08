import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_app/model/theme.dart';
import 'package:shopping_app/provider/setting_provider.dart';
import 'package:shopping_app/provider/token_provider.dart';
import 'package:shopping_app/screen/exception/exception_page.dart';
import 'package:shopping_app/screen/login/login_page.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:shopping_app/screen/root/root_screen.dart';

final tokenFutureProvider = FutureProvider<bool>((ref) async {
  await ref.read(tokenProvider.notifier).loadToken();
  return ref.read(tokenProvider).hasData();
});

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
        themeMode: ref.watch(settingProvider).themeData,
        home: ref.watch(tokenFutureProvider).when(
              data: (hasToken) {
                return hasToken ? const RootScreen() : const LoginPage();
              },
              loading: () =>
                  const Center(child: CircularProgressIndicator.adaptive()),
              error: (error, stackTrace) {
                return Center(
                  child: ExceptionPage(message: error.toString()),
                );
              },
            ),
      ),
    );
  }
}
