class Message {
  final String text;
  final bool isUser;
  final bool isSystem;
  final bool isImageMode;

  Message({
    required this.text,
    required this.isUser,
    this.isSystem = false,
    this.isImageMode = false,
  });
}
