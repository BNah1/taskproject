import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskproject/core/constant/app_enum.dart';
import 'package:taskproject/feature/task/state/task_controller_model.dart';
import 'package:taskproject/model/task_model.dart';
import 'package:taskproject/model/user_model.dart';
import 'package:taskproject/repository/task_repository.dart';
import 'package:taskproject/service/task_project_service.dart';

class TaskCubit extends Cubit<TaskControllerModel> {
  final TaskRepository _repository;
  final TaskProjectService _taskProjectService;

  TaskCubit({
    required TaskRepository repository,
    required TaskProjectService taskProjectService,
  })  : _repository = repository,
        _taskProjectService = taskProjectService,
        super(TaskControllerModel());


  Future<void> init() async {
    emit(state.copyWith(status: BaseStatus.initial));
    try {
      emit(state.copyWith(status: BaseStatus.loading));
      final listTask = await _repository.getAllTask();
      emit(state.copyWith(status: BaseStatus.loaded, listTask: listTask));
    } catch (e) {
      emit(
        state.copyWith(status: BaseStatus.error, errorMessage: e.toString()),
      );
    }
  }

  Future<String?> deleteTask(TaskModel task)async {
    try {
      emit(state.copyWith(status: BaseStatus.loading));

      await _taskProjectService.deleteTask(task);

      final updatedTasks = List<TaskModel>.from(state.listTask)..removeWhere((t) => task.taskId == t.taskId);

      emit(state.copyWith(status: BaseStatus.loaded, listTask: updatedTasks));

      return null;
    } catch (e) {
      emit(
        state.copyWith(status: BaseStatus.error, errorMessage: e.toString()),
      );
      return e.toString();
    }
  }

  Future<void> addTask({
    required String taskName,
    required DateTime taskDeadLineMin,
    required UserModel taskCreatedBy,
    required String descriptions,
    required String urgent,
    required String projectId,
    required DateTime taskDeadLineMax,
  }) async {
    try {
      emit(state.copyWith(status: BaseStatus.loading));

      final length = state.listTask.length +1;
      final id = 't0$length';

      final TaskModel task = TaskModel(
        taskName,
        id,
        taskDeadLineMin,
        [],
        taskCreatedBy,
        [],
        descriptions,
        urgent,
        projectId,
        taskDeadLineMax,
        0,
        'TODO',
      );

      await _taskProjectService.addTask(task);

      final updatedTasks = List<TaskModel>.from(state.listTask)..add(task);

      emit(state.copyWith(status: BaseStatus.loaded, listTask: updatedTasks));
    } catch (e) {
      emit(
        state.copyWith(status: BaseStatus.error, errorMessage: e.toString()),
      );
    }
  }

  Future<void> updateTask({required TaskModel task}) async {
    try {
      emit(state.copyWith(status: BaseStatus.loading));
      final updatedTasks = state.listTask.map((t) {
        return t.taskName == task.taskName ? task : t;
      }).toList();

      emit(state.copyWith(status: BaseStatus.loaded, listTask: updatedTasks));
    } catch (e) {
      emit(
        state.copyWith(status: BaseStatus.error, errorMessage: e.toString()),
      );
    }
  }
}
