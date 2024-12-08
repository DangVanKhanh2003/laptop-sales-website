import 'package:jwt_decode/jwt_decode.dart';
import 'package:shopping_app/model/token_state.dart';

class JwtHelper {
  static Map<String, dynamic> decodeJWT(TokenState token) {
    final jwtToken = Jwt.parseJwt(token.accessToken!);
    return jwtToken;
  }
}
