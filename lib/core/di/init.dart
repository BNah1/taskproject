import 'package:taskproject/feature/chat/state/chat_state.dart';
import 'package:taskproject/feature/project/state/project_state.dart';

late final ChatCubit chatCubit;
late final ProjectCubit projectCubit;

class AppInit{
  static Future<void> init()async {
    chatCubit = ChatCubit();
    projectCubit = ProjectCubit();
  }
}