import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class TokenState {
  String? accessToken;
  String? refreshToken;

  TokenState({
    this.accessToken,
    this.refreshToken,
  });

  TokenState copyWith({
    String? accessToken,
    String? refreshToken,
  }) {
    return TokenState(
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
    );
  }

  void clone(TokenState other) {
    if (other.accessToken != null) {
      accessToken = other.accessToken;
    }
    if (other.refreshToken != null) {
      refreshToken = other.refreshToken;
    }
  }

  TokenState copy(
    TokenState other,
  ) {
    return TokenState(
      accessToken: other.accessToken ?? accessToken,
      refreshToken: other.refreshToken ?? refreshToken,
    );
  }

  Future<TokenState> save() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', jsonEncode(toJson()));
    return this;
  }

  bool hasData() {
    return accessToken != null && refreshToken != null;
  }

  TokenState.fromJson(Map<String, dynamic> json) {
    accessToken = json['AccessToken'];
    refreshToken = json['RefreshToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['AccessToken'] = accessToken;
    data['RefreshToken'] = refreshToken;
    return data;
  }

  String toAuthorizationJson() {
    return jsonEncode(toJson());
  }

  void clear() {
    accessToken = null;
    refreshToken = null;
  }
}
