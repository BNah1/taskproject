import 'package:taskproject/model/user_model.dart';

class TaskModel {
  final String projectId;
  final String taskId;
  final String taskName;
  final DateTime taskDeadLineMin;
  final DateTime taskDeadLineMax;
  final double progress;
  final List<UserModel> taskAssigned;
  final UserModel taskCreatedBy;
  final List<String> subTasks;
  final String descriptions;
  final String urgent;
  final String taskTypeProgress;

  TaskModel(
    this.taskName,
    this.taskId,
    this.taskDeadLineMin,
    this.taskAssigned,
    this.taskCreatedBy,
    this.subTasks,
    this.descriptions,
    this.urgent,
    this.projectId,
    this.taskDeadLineMax,
    this.progress,
    this.taskTypeProgress,
  );
}
