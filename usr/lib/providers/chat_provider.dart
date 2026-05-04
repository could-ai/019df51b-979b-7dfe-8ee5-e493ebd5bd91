import 'package:flutter/material.dart';
import '../models/message.dart';
import '../services/gemini_service.dart';

class ChatProvider extends ChangeNotifier {
  final List<Message> _messages = [];
  final GeminiService _geminiService = GeminiService();
  
  bool _isCreatorMode = false;
  bool _isImageMode = false;
  bool _isLoading = false;

  List<Message> get messages => _messages;
  bool get isCreatorMode => _isCreatorMode;
  bool get isImageMode => _isImageMode;
  bool get isLoading => _isLoading;

  void toggleMode(bool isImage) {
    _isImageMode = isImage;
    notifyListeners();
  }

  void _addMessage(Message message) {
    _messages.add(message);
    notifyListeners();
  }

  Future<void> sendMessage(String text) async {
    final t = text.trim();
    if (t.isEmpty) return;

    // Check for Creator Login
    if (t == "MaliAicreator2712%") {
      _isCreatorMode = true;
      _addMessage(Message(
        text: "Welcome back, Malakai (Creator Mode Active)",
        isUser: false,
        isSystem: true,
      ));
      return;
    }

    // Check Admin Commands
    if (t.startsWith('/')) {
      if (!_isCreatorMode) {
        _addMessage(Message(text: t, isUser: true));
        _addMessage(Message(text: "Unauthorized", isUser: false, isSystem: true));
        return;
      }
      
      _addMessage(Message(text: t, isUser: true));
      
      if (t == '/clear') {
        _messages.clear();
        notifyListeners();
      } else if (t == '/system') {
        _addMessage(Message(text: "System Info: Mali AI v1.0. All systems nominal.", isUser: false, isSystem: true));
      } else if (t == '/mode') {
        _addMessage(Message(text: "Creator mode is currently Active.", isUser: false, isSystem: true));
      } else {
        _addMessage(Message(text: "Unknown command.", isUser: false, isSystem: true));
      }
      return;
    }

    // Normal message flow
    _addMessage(Message(text: t, isUser: true));

    if (_isImageMode) {
      // Simulate image generation delay
      _isLoading = true;
      notifyListeners();
      await Future.delayed(const Duration(seconds: 1));
      _isLoading = false;
      _addMessage(Message(text: "Image generation coming soon", isUser: false, isSystem: true));
      return;
    }

    _isLoading = true;
    notifyListeners();

    final response = await _geminiService.generateResponse(t, _isCreatorMode);
    
    _isLoading = false;
    _addMessage(Message(text: response, isUser: false));
  }
}
