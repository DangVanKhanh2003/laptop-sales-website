import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

class ImageHelper {
  static Future<Uint8List?> pickImage({
    required ImageSource source,
  }) async {
    final ImagePicker picker = ImagePicker();
    if (kIsWeb) {
      return await _pickImageForWeb(picker: picker, source: source);
    } else {
      return await _pickImageForMobile(picker: picker, source: source);
    }
  }

  static Future<Uint8List?> _pickImageForMobile({
    required ImagePicker picker,
    required ImageSource source,
  }) async {
    final XFile? pickedFile = await picker.pickImage(source: source);
    return pickedFile != null ? File(pickedFile.path).readAsBytesSync() : null;
  }

  static Future<Uint8List?> _pickImageForWeb({
    required ImagePicker picker,
    required ImageSource source,
  }) async {
    if (source == ImageSource.camera) {
      throw UnsupportedError("Camera is not supported on web.");
    }
    final XFile? pickedFile = await picker.pickImage(source: source);
    return pickedFile != null ? await pickedFile.readAsBytes() : null;
  }
}
