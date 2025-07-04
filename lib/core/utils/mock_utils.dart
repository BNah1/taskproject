import 'package:taskproject/core/mock/data.dart';
import 'package:taskproject/model/chat_room_model.dart';
import 'package:taskproject/model/message_model.dart';
import 'package:taskproject/model/project_model.dart';
import 'package:taskproject/model/task_model.dart';
import 'package:taskproject/model/user_model.dart';

Future<List<ProjectModel>> getListProject() async {
  await Future.delayed(const Duration(seconds: 2));
  return MockData.listProjectMock;
}

Future<List<TaskModel>> getListTask() async {
  await Future.delayed(const Duration(seconds: 2));
  return MockData.listTaskMock;
}

List<Message> getListMessage(String chatRoomId) {
  final messages = MockData.mockMessage[chatRoomId];
  if (messages == null) {
    return [];
  }
  return messages;
}

Future<Map<String, List<Message>>> getListMessageAll() async {
  await Future.delayed(const Duration(seconds: 1));
  final messages = MockData.mockMessage;
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

  String getChatRoomId(String myId, String userId)  {
  try {
    final ChatRoom room = MockData.mockChatRooms.firstWhere(
          (e) => e.members.contains(myId) && e.members.contains(userId),
    );
    return room.chatroomId;
  } catch (e) {
    return 'error';
  }
}

Future<List<ChatRoom>> getChatRoom() async {
  await Future.delayed(const Duration(seconds: 1));
  return MockData.mockChatRooms;
}
