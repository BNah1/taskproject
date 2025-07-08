import 'dart:async';

import 'package:taskproject/model/task_model.dart';
import 'package:taskproject/service/task_service.dart';

class TaskRepository{
  final TaskService _service;
  TaskRepository(this._service);


  Future<List<TaskModel>> getAllTask() => _service.getAllTask();
}