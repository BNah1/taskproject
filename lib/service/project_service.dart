import 'package:taskproject/core/mock/data.dart';
import 'package:taskproject/model/project_model.dart';

class ProjectService{

  Future<List<ProjectModel>> getAllProject() async {
    await Future.delayed(const Duration(seconds: 2));
    return MockData.listProjectMock;
  }

}