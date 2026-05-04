class Message {
  final String text;
  final bool isUser;
  final bool isSystem;

  Message({
    required this.text,
    required this.isUser,
    this.isSystem = false,
  });
}
