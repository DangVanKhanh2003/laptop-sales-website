import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiService {
  late final GenerativeModel _model;

  GeminiService()
      : _model = GenerativeModel(
          model: 'gemini-1.5-flash-latest',
          apiKey: dotenv.env['GEMINI_API']!,
        );

  Future<String?> ask({
    required String message,
  }) async {
    final content = [Content.text(message)];
    final response = await _model.generateContent(content);
    return response.text;
  }
}
