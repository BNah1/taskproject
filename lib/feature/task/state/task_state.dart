import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:taskproject/core/constant/app_enum.dart';
import 'package:taskproject/feature/task/state/task_controller_model.dart';
import 'package:taskproject/model/task_model.dart';
import 'package:taskproject/model/user_model.dart';
import 'package:taskproject/repository/task_repository.dart';

class TaskCubit extends Cubit<TaskControllerModel> {
  TaskCubit() : super(TaskControllerModel());
  final _repository = GetIt.I<TaskRepository>();

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

  Future<void> addTask({
    required String taskName,
    required String taskId,
    required DateTime taskDeadLineMin,
    required UserModel taskCreatedBy,
    required List<String> subTasks,
    required String descriptions,
    required String urgent,
    required String projectId,
    required DateTime taskDeadLineMax,
    required String taskTypeProgress,
  }) async {
    try {
      emit(state.copyWith(status: BaseStatus.loading));

      final TaskModel task = TaskModel(
        taskName,
        taskId,
        taskDeadLineMin,
        [],
        taskCreatedBy,
        subTasks,
        descriptions,
        urgent,
        projectId,
        taskDeadLineMax,
        0,
        taskTypeProgress,
      );

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
