import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:taskproject/core/constant/app_enum.dart';
import 'package:taskproject/feature/project/state/project_controller_model.dart';
import 'package:taskproject/model/project_model.dart';
import 'package:taskproject/model/task_model.dart';
import 'package:taskproject/model/user_model.dart';
import 'package:taskproject/repository/project_repository.dart';

class ProjectCubit extends Cubit<ProjectControllerModel> {
  ProjectCubit() : super(ProjectControllerModel());
  final _repository = GetIt.I<ProjectRepository>();

  Future<void> init() async {
    emit(state.copyWith(status: BaseStatus.initial));
    try {
      emit(state.copyWith(status: BaseStatus.loading));
      List<ProjectModel> list = await _repository.getAllProject();
      emit(state.copyWith(status: BaseStatus.loaded, listProject: list));
    } catch (e) {
      emit(
        state.copyWith(status: BaseStatus.error, errorMessage: e.toString()),
      );
    }
  }

  Future<void> addProject({
    required String projectName,
    required DateTime taskDeadLine,
    required String description,
    required String typeProcess,
    required String urgent,
    required String type,
    required UserModel taskCreatedBy,
  }) async {
    try {
      emit(state.copyWith(status: BaseStatus.loading));
      final projectId = 'p00${state.listProject.length +1}';

      ProjectModel project = ProjectModel(
        projectId: projectId,
        projectName: projectName,
        taskDeadLine: taskDeadLine,
        taskAssigned: [],
        taskCreatedBy: taskCreatedBy,
        listTask: [],
        progress: 0,
        description: description,
        typeProcess: typeProcess,
        urgent: urgent,
        type: type,
      );

      final updatedList = state.listProject;
      updatedList.add(project);

      emit(state.copyWith(listProject: updatedList, status: BaseStatus.loaded));
    } catch (e) {
      emit(
        state.copyWith(status: BaseStatus.error, errorMessage: e.toString()),
      );
    }
  }

  Future<void> updateProject({
    required String projectId,
    String? projectName,
    DateTime? taskDeadLine,
    List<UserModel>? taskAssigned,
    List<TaskModel>? listTask,
    double? progress,
    String? description,
    String? typeProcess,
    String? urgent,
    String? type,
  }) async {
    try {
      emit(state.copyWith(status: BaseStatus.loading));

      final exists = state.listProject.any((e) => e.projectId == projectId);
      if (!exists) {
        throw Exception('Project with ID $projectId not found');
      }

      final updatedList = state.listProject.map((e) {
        if (e.projectId == projectId) {
          return e.copyWith(
            projectName: projectName,
            taskDeadLine: taskDeadLine,
            taskAssigned: taskAssigned,
            listTask: listTask,
            progress: progress,
            description: description,
            typeProcess: typeProcess,
            urgent: urgent,
            type: type,
          );
        }
        return e;
      }).toList();

      emit(state.copyWith(listProject: updatedList, status: BaseStatus.loaded));
    } catch (e) {
      emit(
        state.copyWith(status: BaseStatus.error, errorMessage: e.toString()),
      );
    }
  }
}
