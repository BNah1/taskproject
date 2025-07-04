import 'package:taskproject/core/constant/app_enum.dart';
import 'package:taskproject/model/base_state.dart';
import 'package:taskproject/model/chat_room_model.dart';
import 'package:taskproject/model/message_model.dart';

class ChatControllerModel extends BaseState{
  final List<ChatRoom> chatRooms;
  final Map<String, List<Message>> messages;

  ChatControllerModel({
    super.status = BaseStatus.initial,
    super.errorMessage = '',
    this.chatRooms = const [],
    this.messages = const {},
  });

  ChatControllerModel copyWith({
    BaseStatus? status,
    String? errorMessage,
    List<ChatRoom>? chatRooms,
    Map<String, List<Message>>? messages,
  }) {
    return ChatControllerModel(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      chatRooms: chatRooms ?? this.chatRooms,
      messages: messages ?? this.messages,
    );
  }
}