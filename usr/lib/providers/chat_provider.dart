import 'package:flutter/material.dart';
import '../models/message.dart';
import '../services/gemini_service.dart';

class ChatProvider extends ChangeNotifier {
  final List<Message> _messages = [];
  final GeminiService _geminiService = GeminiService();
  
  bool _isCreatorMode = false;
  bool _isImageMode = false;
  bool _isLoading = false;

  List<Map<String, String>> _trendingTopics = [
    {'title': 'Future of AI', 'timestamp': '10 mins ago'},
    {'title': 'Flutter Web Dev', 'timestamp': '1 hr ago'},
    {'title': 'Gemini API Features', 'timestamp': '2 hrs ago'},
    {'title': 'Dark Mode UI Trends', 'timestamp': '3 hrs ago'},
  ];

  List<Message> get messages => _messages;
  bool get isCreatorMode => _isCreatorMode;
  bool get isImageMode => _isImageMode;
  bool get isLoading => _isLoading;
  List<Map<String, String>> get trendingTopics => _trendingTopics;

  void refreshTrending() {
    _trendingTopics = [
      {'title': 'Dart 3.0 Patterns', 'timestamp': 'Just now'},
      {'title': 'Responsive Web Design', 'timestamp': '5 mins ago'},
      {'title': 'State Management', 'timestamp': '15 mins ago'},
      {'title': 'AI Automation', 'timestamp': '30 mins ago'},
    ];
    notifyListeners();
  }

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
        isImageMode: _isImageMode,
      ));
      return;
    }

    // Check Admin Commands
    if (t.startsWith('/')) {
      if (!_isCreatorMode) {
        _addMessage(Message(text: t, isUser: true, isImageMode: _isImageMode));
        _addMessage(Message(text: "Unauthorized", isUser: false, isSystem: true, isImageMode: _isImageMode));
        return;
      }
      
      _addMessage(Message(text: t, isUser: true, isImageMode: _isImageMode));
      
      if (t == '/clear') {
        _messages.clear();
        notifyListeners();
      } else if (t == '/system') {
        _addMessage(Message(text: "System Info: Mali AI v1.0. All systems nominal.", isUser: false, isSystem: true, isImageMode: _isImageMode));
      } else if (t == '/mode') {
        _addMessage(Message(text: "Creator mode is currently Active.", isUser: false, isSystem: true, isImageMode: _isImageMode));
      } else {
        _addMessage(Message(text: "Unknown command.", isUser: false, isSystem: true, isImageMode: _isImageMode));
      }
      return;
    }

    // Normal message flow
    _addMessage(Message(text: t, isUser: true, isImageMode: _isImageMode));

    if (_isImageMode) {
      // Simulate image generation delay
      _isLoading = true;
      notifyListeners();
      await Future.delayed(const Duration(seconds: 1));
      _isLoading = false;
      _addMessage(Message(text: "Image generation coming soon [placeholder]", isUser: false, isSystem: true, isImageMode: true));
      return;
    }

    _isLoading = true;
    notifyListeners();

    final response = await _geminiService.generateResponse(t, _isCreatorMode);
    
    _isLoading = false;
    _addMessage(Message(text: response, isUser: false, isImageMode: _isImageMode));
  }
}
