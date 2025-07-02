import 'package:taskproject/core/mock/data.dart';
import 'package:taskproject/model/project_model.dart';
import 'package:taskproject/model/task_model.dart';

Future<List<ProjectModel>> getListProject() async {
  await Future.delayed(const Duration(seconds: 2));
  return MockData.listProjectMock;
}

Future<List<TaskModel>> getListTask() async {
  await Future.delayed(const Duration(seconds: 2));
  return MockData.listTaskMock;
}