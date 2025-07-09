import 'package:taskproject/model/project_model.dart';

extension ProjectListHelper on List<ProjectModel>{

  ProjectModel getProject(String projectId) {
    return firstWhere(
          (e) => e.projectId == projectId,
      orElse: () => throw Exception('Project not found'),
    );
  }

  List<ProjectModel> updateProject(String projectId, ProjectModel Function(ProjectModel) updateFn) {
    return map((e) {
      if (e.projectId == projectId) return updateFn(e);
      return e;
    }).toList();
  }

}