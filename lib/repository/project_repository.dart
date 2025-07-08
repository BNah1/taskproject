import 'package:taskproject/model/project_model.dart';
import 'package:taskproject/service/project_service.dart';

class ProjectRepository{
  final ProjectService _service;
  ProjectRepository(this._service);

  Future<List<ProjectModel>> getAllProject() => _service.getAllProject();

  // Future<List<ProjectModel>> getListProjectById(UserModel user) async {
  //   final list = await getAllProject();
  //   final newList = list.where((e) => e.taskAssigned.contains(user)).toList();
  //   return newList;
  // }

}