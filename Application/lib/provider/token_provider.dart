import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_app/model/token_state.dart';
import 'package:shopping_app/service/jwt_helper.dart';

final tokenProvider = StateNotifierProvider<TokenProvider, TokenState>(
  (ref) => TokenProvider(),
);

class TokenProvider extends StateNotifier<TokenState> {
  TokenProvider() : super(TokenState());

  late int _customerId;

  int get customerId => _customerId;

  late String _email;

  String get email => _email;

  Future<void> loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token == null) {
      return;
    }
    state = state.copy(TokenState.fromJson(jsonDecode(token)));
    final jwtToken = JwtHelper.decodeJWT(state);
    _customerId = int.parse(jwtToken['Id']);
    _email = jwtToken['Email'];
  }

  Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }

  Future<void> saveToken(TokenState token) async {
    state = await token.save();
  }
}
