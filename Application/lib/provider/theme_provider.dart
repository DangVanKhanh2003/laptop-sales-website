import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final themeProvider = StateNotifierProvider<ThemeProvider, ThemeMode>(
  (_) => ThemeProvider(),
);

class ThemeProvider extends StateNotifier<ThemeMode> {
  final String _key = "isDarkMode";

  ThemeProvider() : super(ThemeMode.system) {
    _loadTheme();
  }

  ThemeMode _exchangeTheme(String theme) {
    const data = {
      'light': ThemeMode.light,
      'dark': ThemeMode.dark,
    };
    return data[theme] ?? ThemeMode.system;
  }

  void _loadTheme() async {
    final pref = await SharedPreferences.getInstance();
    final theme = pref.getString(_key) ?? 'system';
    state = _exchangeTheme(theme);
  }

  set theme(String theme) {
    state = _exchangeTheme(theme);
  }
}
