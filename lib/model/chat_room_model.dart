class ChatRoom {
  final String chatroomId;
  final String lastMessage;
  final DateTime lastMessageTs;
  final List<String> members;
  final DateTime createdAt;

  const ChatRoom({
    required this.chatroomId,
    required this.lastMessage,
    required this.lastMessageTs,
    required this.members,
    required this.createdAt,
  });
}