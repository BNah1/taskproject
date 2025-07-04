import 'package:taskproject/feature/chat/state/chat_state.dart';

late final ChatCubit chatCubit;

class AppInit{
  static Future<void> init()async {
    chatCubit = ChatCubit();
  }
}