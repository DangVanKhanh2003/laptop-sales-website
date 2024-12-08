import 'dart:convert';
import 'dart:typed_data';

class ConvertHelper {
  static Uint8List decodeBase64({
    required String data,
  }) {
    return base64.decode(data);
  }

  static String encodeBase64({
    required Uint8List data,
  }) {
    return base64.encode(data);
  }
}
