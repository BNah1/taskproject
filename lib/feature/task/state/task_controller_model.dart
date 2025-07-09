import 'package:taskproject/core/constant/app_enum.dart';
import 'package:taskproject/model/base_state.dart';
import 'package:taskproject/model/task_model.dart';
import 'package:taskproject/model/user_model.dart';

class TaskControllerModel extends BaseState {
  final List<TaskModel> listTask;

  TaskControllerModel({
    super.status = BaseStatus.initial,
    super.errorMessage = '',
    this.listTask = const [],
  });

  @override
  TaskControllerModel copyWith({
    List<TaskModel>? listTask,
    BaseStatus? status,
    String? errorMessage,
  }) {
    return TaskControllerModel(
      listTask: listTask ?? this.listTask,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  List<TaskModel> getListById(UserModel user) {
    final list = listTask
        .where((e) => e.taskAssigned.contains(user) || e.taskCreatedBy == user)
        .toList();
    return list;
  }
}
