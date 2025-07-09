import 'package:get_it/get_it.dart';
import 'package:taskproject/extension/project_list_extension.dart';
import 'package:taskproject/feature/project/state/project_state.dart';
import 'package:taskproject/feature/task/state/task_state.dart';
import 'package:taskproject/model/task_model.dart';
import 'package:taskproject/repository/project_repository.dart';
import 'package:taskproject/repository/task_repository.dart';

class TaskProjectService {
  final _taskRepository = GetIt.I<TaskRepository>();
  // final _projectRepository = GetIt.I<ProjectRepository>();

  final ProjectCubit _projectCubit;
  // final TaskCubit _taskCubit;

  TaskProjectService(this._projectCubit,
      // this._taskCubit
      );

  Future<void> addTask(TaskModel task) async {
    /// add task
    await _taskRepository.deleteTask(task);

    /// get update list
    final listTask = _projectCubit.state.listProject.getProject(task.projectId).listTask;
    final updateList = List<TaskModel>.from(listTask)..removeWhere((t) => t.taskId == task.taskId);

    /// update project
    await _projectCubit.updateProject(
      projectId: task.projectId,
      listTask: updateList,
    );
  }

  Future<void> deleteTask(TaskModel task) async {
    /// add task
    await _taskRepository.addTask(task);

    /// get update list
    final listTask = _projectCubit.state.listProject.getProject(task.projectId).listTask;
    final updateList = List<TaskModel>.from(listTask)..add(task);

    /// update project
    await _projectCubit.updateProject(
      projectId: task.projectId,
      listTask: updateList,
    );
  }

}
