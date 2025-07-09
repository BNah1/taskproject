import 'package:taskproject/feature/project/state/project_state.dart';
import 'package:taskproject/feature/task/state/task_state.dart';

class ProjectTaskUseCase{
  final TaskCubit taskCubit;
  final ProjectCubit projectCubit;

  ProjectTaskUseCase(this.taskCubit, this.projectCubit);


  Future<String?> deleteProject(String projectId) async {
    try{
      await projectCubit.deleteProject(projectId);
      await taskCubit.deleteTaskByProjectId(projectId);
      return null;
    }catch(e){
      return e.toString();
    }
  }

}