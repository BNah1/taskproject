import 'package:taskproject/model/task_model.dart';
import 'package:taskproject/model/user_model.dart';

class ProjectModel {
  final String projectId;
  final String projectName;
  final DateTime taskDeadLine;
  final List<UserModel> taskAssigned;
  final UserModel taskCreatedBy;
  final List<TaskModel> listTask;
  final double progress;
  final String description;
  String type;
  final String urgent;

  ProjectModel({
    required this.projectId,
    required this.projectName,
    required this.taskDeadLine,
    required this.taskAssigned,
    required this.taskCreatedBy,
    required this.listTask,
    required this.progress,
    required this.description,
    required this.type,
    required this.urgent
  });
}
