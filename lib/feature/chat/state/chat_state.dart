import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:taskproject/core/constant/app_enum.dart';
import 'package:taskproject/model/message_model.dart';
import 'package:taskproject/repository/chat_repository.dart';
import 'chat_controller_model.dart';

class ChatCubit extends Cubit<ChatControllerModel> {
  ChatCubit() : super(ChatControllerModel());
  final ChatRepository _repository = GetIt.I<ChatRepository>();

  Future<void> init() async {
    emit(state.copyWith(status: BaseStatus.loading));

    try {
      final chatRooms = await _repository.getChatRooms();
      final messages = await _repository.getAllMessages();

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
