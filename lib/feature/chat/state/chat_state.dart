import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskproject/core/constant/app_enum.dart';
import 'package:taskproject/core/utils/mock_utils.dart';
import 'package:taskproject/model/message_model.dart';

import 'chat_controller_model.dart';

class ChatCubit extends Cubit<ChatControllerModel> {
  ChatCubit() : super(ChatControllerModel());

  init() async {
    emit(state.copyWith(status: BaseStatus.loading));

    try {
      final chatRooms = await getChatRoom();
      final messages = await getListMessageAll();

      emit(
        state.copyWith(
          chatRooms: chatRooms,
          messages: messages,
          status: BaseStatus.loaded,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(status: BaseStatus.error, errorMessage: e.toString()),
      );
    }
  }

  addChat(Message message, String chatRoomId) async {
    final messages = state.messages;

    emit(state.copyWith(status: BaseStatus.loading));

    try {
      final roomMessages = List<Message>.from(messages[chatRoomId] ?? []);

      roomMessages.insert(0, message);
      // Cập nhật lại map
      messages[chatRoomId] = roomMessages;

      emit(state.copyWith(messages: messages, status: BaseStatus.loaded));
    } catch (e) {
      emit(
        state.copyWith(status: BaseStatus.error, errorMessage: e.toString()),
      );
    }
  }
}
