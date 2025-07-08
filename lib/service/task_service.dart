import 'package:taskproject/core/mock/data.dart';
import 'package:taskproject/model/task_model.dart';

class TaskService{

  Future<List<TaskModel>> getAllTask() async {
    try{
      await Future.delayed(const Duration(seconds: 1));
      return MockData.listTaskMock;
    }catch(e){
      return [];
    }
  }
}