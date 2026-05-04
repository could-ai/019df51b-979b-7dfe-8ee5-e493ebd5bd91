import 'dart:convert';
import 'package:http/http.dart' as http;

class GeminiService {
  static const String _apiKey = "AIzaSyDL_8FrKYr4caW1z03gpfx19Lims3mTqCk";
  static const String _apiUrl =
      "https://generativelanguage.googleapis.com/v1/models/gemini-pro:generateContent";

  Future<String> generateResponse(String prompt, bool isCreatorMode) async {
    final url = Uri.parse('$_apiUrl?key=$_apiKey');
    
    String finalPrompt = prompt;
    if (isCreatorMode) {
      finalPrompt = "System note: The user is Malakai, the creator of Mali AI. Acknowledge this naturally.\n\nUser: $prompt";
    }

    final Map<String, dynamic> requestBody = {
      "contents": [
        {
          "parts": [
            {"text": finalPrompt}
          ]
        }
      ]
    };

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(requestBody),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final content = data['candidates']?[0]['content']?['parts']?[0]['text'];
        return content ?? "I couldn't generate a response.";
      } else {
        return "Error: Could not connect to Gemini API. ${response.body}";
      }
    } catch (e) {
      return "Error: $e";
    }
  }
}
