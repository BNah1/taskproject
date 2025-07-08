import 'package:taskproject/core/mock/data.dart';
import 'package:taskproject/model/chat_room_model.dart';
import 'package:taskproject/model/message_model.dart';
import 'package:taskproject/model/user_model.dart';



List<Message> getListMessage(String chatRoomId) {
  final messages = MockData.mockMessage[chatRoomId];
  if (messages == null) {
    return [];
  }
  return messages;
}


 UserModel getUser(String userId)  {
  final list = MockData.listUserMock;
  final user = list.firstWhere((e) => e.id == userId);
  return user;
}

  String getUserPathImage(String userId) {
  final list = MockData.listUserMock;
  final user = list.firstWhere((e) => e.id == userId);
  final path = user.pathImage ;
  return path;
}


String getChatRoomId1(String myId, String userId, List<ChatRoom> rooms)  {
  try {
    final ChatRoom room = rooms.firstWhere(
          (e) => e.members.contains(myId) && e.members.contains(userId),
    );
    return room.chatroomId;
  } catch (e) {
    return 'error';
  }
}

