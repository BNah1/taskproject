import 'package:flutter/cupertino.dart';
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

  Future<void> addTask(TaskModel task) async {
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      MockData.listTaskMock.add(task);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> deleteTask(TaskModel task) async {
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      MockData.listTaskMock.removeWhere((t) => t.taskId == task.taskId);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

}