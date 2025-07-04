class Message {
  final String message;
  final String messageId;
  final String senderId;
  final String receiverId;
  final DateTime timestamp;
  final bool seen;

  const Message({
    required this.message,
    required this.messageId,
    required this.senderId,
    required this.receiverId,
    required this.timestamp,
    required this.seen,
  });
}
