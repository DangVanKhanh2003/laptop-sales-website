import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final settingProvider = StateNotifierProvider<SettingProvider, SettingState>(
  (ref) => SettingProvider(),
);

class SettingState {
  final String theme;
  final bool sendNotification;
  final bool allowLocation;

  SettingState({
    this.theme = 'system',
    this.sendNotification = false,
    this.allowLocation = false,
  });

  ThemeMode get themeData {
    final Map<String, ThemeMode> exchanger = {
      'system': ThemeMode.system,
      'dark': ThemeMode.dark,
      'light': ThemeMode.light,
    };
    return exchanger[theme] ?? ThemeMode.system;
  }

  SettingState copyWith({
    String? theme,
    bool? sendNotification,
    bool? allowLocation,
  }) {
    return SettingState(
      theme: theme ?? this.theme,
      sendNotification: sendNotification ?? this.sendNotification,
      allowLocation: allowLocation ?? this.allowLocation,
    );
  }
}

class SettingProvider extends StateNotifier<SettingState> {
  SettingProvider() : super(SettingState()) {
    _loadSetting();
  }

  Future<void> _loadSetting() async {
    final prefs = await SharedPreferences.getInstance();
    state = state.copyWith(
      theme: prefs.getString('theme'),
      sendNotification: prefs.getBool('sendNotification'),
      allowLocation: prefs.getBool('allowLocation'),
    );
  }

  Future<void> setTheme(String theme) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('theme', theme);
    state = state.copyWith(theme: theme);
  }

  Future<void> setSendNotification(bool sendNotification) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('sendNotification', sendNotification);
    state = state.copyWith(sendNotification: sendNotification);
  }

  Future<void> setAllowLocation(bool allowLocation) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('allowLocation', allowLocation);
    state = state.copyWith(allowLocation: allowLocation);
  }
}
