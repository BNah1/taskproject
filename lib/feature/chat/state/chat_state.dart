import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskproject/core/utils/mock_utils.dart';
import 'package:taskproject/model/message_model.dart';

import 'chat_controller_model.dart';

class ChatCubit extends Cubit<ChatControllerModel>{
  ChatCubit() : super(ChatControllerModel());

  init() async{
    final chatRooms = await getChatRoom();
    final messages = await getListMessageAll();

    emit(state.copyWith(chatRooms: chatRooms,messages: messages));
  }

  addChat(Message message, String chatRoomId) async{
    final messages = state.messages;
    final roomMessages = List<Message>.from(messages[chatRoomId] ?? []);

    roomMessages.insert(0,message);
    // Cập nhật lại map
    messages[chatRoomId] = roomMessages;

    emit(state.copyWith(messages: messages));
  }
}