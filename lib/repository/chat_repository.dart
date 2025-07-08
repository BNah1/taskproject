import 'package:taskproject/model/chat_room_model.dart';
import 'package:taskproject/model/message_model.dart';
import 'package:taskproject/service/chat_service.dart';

class ChatRepository{
  final ChatService _service;
  ChatRepository(this._service);

  Future<List<ChatRoom>> getChatRooms() => _service.getChatRooms();

  Future<Map<String, List<Message>>> getAllMessages() => _service.getListAllMessage();

  List<Message> getMessagesByRoom(String chatRoomId) => _service.getMessagesByRoom(chatRoomId);

  Future<String> getChatRoomId(String myId, String userId) async {
    try {
      final rooms = await _service.getChatRooms();
      final room = rooms.firstWhere(
            (e) => e.members.contains(myId) && e.members.contains(userId),
      );
      return room.chatroomId;
    } catch (_) {
      return 'error';
    }
  }

}