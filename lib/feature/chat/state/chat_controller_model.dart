import 'package:taskproject/model/chat_room_model.dart';
import 'package:taskproject/model/message_model.dart';

class ChatControllerModel{
  final List<ChatRoom> chatRooms;
  final Map<String, List<Message>> messages;

  ChatControllerModel({
    this.chatRooms = const [],
    this.messages = const {},
  });

  ChatControllerModel copyWith({
    List<ChatRoom>? chatRooms,
    Map<String, List<Message>>? messages,
  }) {
    return ChatControllerModel(
      chatRooms: chatRooms ?? this.chatRooms,
      messages: messages ?? this.messages,
    );
  }
}