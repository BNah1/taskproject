import 'package:taskproject/model/task_model.dart';

extension TaskListHelper on List<TaskModel>{


  TaskModel getTask(String taskId) {
    return firstWhere(
          (e) => e.taskId == taskId,
      orElse: () => throw Exception('Task not found'),
    );
  }


  List<TaskModel> getListTaskByProjectId(String projectId){
    return where((task) => task.projectId == projectId).toList();
  }


}