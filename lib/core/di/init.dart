import 'package:get_it/get_it.dart';
import 'package:taskproject/feature/chat/state/chat_state.dart';
import 'package:taskproject/feature/project/state/project_state.dart';
import 'package:taskproject/feature/task/state/task_state.dart';
import 'package:taskproject/repository/auth_repository.dart';
import 'package:taskproject/repository/chat_repository.dart';
import 'package:taskproject/repository/project_repository.dart';
import 'package:taskproject/repository/task_repository.dart';
import 'package:taskproject/service/auth_service.dart';
import 'package:taskproject/service/chat_service.dart';
import 'package:taskproject/service/project_service.dart';
import 'package:taskproject/service/task_project_service.dart';
import 'package:taskproject/service/task_service.dart';

late final ChatCubit chatCubit;
late final ProjectCubit projectCubit;
late final TaskCubit taskCubit;

final getIt = GetIt.instance;

class AppInit {
  static Future<void> init() async {
    await registerDI();

    await registerSubDI();

    await createCubit();

  }

  static Future<void> registerDI() async {
    getIt.registerLazySingleton<ChatService>(() => ChatService());
    getIt.registerLazySingleton<ChatRepository>(
      () => ChatRepository(getIt<ChatService>()),
    );

    getIt.registerLazySingleton<ProjectService>(() => ProjectService());
    getIt.registerLazySingleton<ProjectRepository>(
      () => ProjectRepository(getIt<ProjectService>()),
    );

    getIt.registerLazySingleton<AuthService>(() => AuthService());
    getIt.registerLazySingleton<AuthRepository>(
      () => AuthRepository(getIt<AuthService>()),
    );

    getIt.registerLazySingleton<TaskService>(() => TaskService());
    getIt.registerLazySingleton<TaskRepository>(
      () => TaskRepository(getIt<TaskService>()),
    );
  }

  static Future<void> createCubit() async {
    chatCubit = ChatCubit();
    projectCubit = ProjectCubit();
    taskCubit = TaskCubit(repository: getIt<TaskRepository>(), taskProjectService: getIt<TaskProjectService>());
  }

  static Future<void> registerSubDI() async {
    getIt.registerLazySingleton<TaskProjectService>(
      () => TaskProjectService(projectCubit,
          // taskCubit
      ),
    );
  }
}
