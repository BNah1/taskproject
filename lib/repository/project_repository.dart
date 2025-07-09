import 'package:taskproject/model/project_model.dart';
import 'package:taskproject/service/project_service.dart';

class ProjectRepository {
  final ProjectService _service;

  ProjectRepository(this._service);

  Future<List<ProjectModel>> getAllProject() => _service.getAllProject();

  Future<List<ProjectModel>> deleteProject({
    required List<ProjectModel> listProject,
    required String projectId,
  }) async {
    try {
      final List<ProjectModel> list = listProject;
      list.removeWhere((e) => e.projectId == projectId);
      return list;
    } catch (e) {
      return listProject;
    }
  }
}
