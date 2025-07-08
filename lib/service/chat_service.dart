import 'package:taskproject/core/mock/data.dart';
import 'package:taskproject/model/chat_room_model.dart';
import 'package:taskproject/model/message_model.dart';

class ChatService{
  Future<List<ChatRoom>> getChatRooms() async {
    await Future.delayed(const Duration(seconds: 1));
    return MockData.mockChatRooms;
  }

  Future<Map<String, List<Message>>> getListAllMessage() async {
    await Future.delayed(const Duration(seconds: 1));
    final messages = MockData.mockMessage;
    return messages;
  }

  List<Message> getMessagesByRoom(String chatRoomId) {
    final messages = MockData.mockMessage[chatRoomId];
    if (messages == null) {
      return [];
    }
    return messages;
  }
}