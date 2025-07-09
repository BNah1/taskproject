import 'package:taskproject/core/constant/app_enum.dart';
import 'package:taskproject/model/base_state.dart';
import 'package:taskproject/model/project_model.dart';
import 'package:taskproject/model/user_model.dart';

class ProjectControllerModel extends BaseState {
  final List<ProjectModel> listProject;

  ProjectControllerModel({
    super.status = BaseStatus.initial,
    super.errorMessage = '',
    this.listProject = const [],
  });



  ProjectControllerModel copyWith({
    BaseStatus? status,
    String? errorMessage,
    List<ProjectModel>? listProject,
  }) {
    return ProjectControllerModel(
      listProject: listProject ?? this.listProject,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  List<ProjectModel> getListByType(TypeProject type) {
    switch (type) {
      case TypeProject.complete:
        return listComplete();
      case TypeProject.inWork:
        return listInWork();
      case TypeProject.todo:
        return listToDo();
    }
  }

  List<ProjectModel> listProjectById(UserModel user){
    return listProject.where((e) => e.taskAssigned.contains(user) || e.taskCreatedBy == user)
        .toList();
  }

  List<ProjectModel> listInWork(){
    return listProject.where((e) => e.typeProcess == "IN WORK")
        .toList();
  }


  List<ProjectModel> listComplete(){
    return listProject.where((e) => e.typeProcess == "COMPLETE")
        .toList();
  }

  List<ProjectModel> listToDo(){
    return listProject.where((e) => e.typeProcess == "TODO")
        .toList();
  }
}
