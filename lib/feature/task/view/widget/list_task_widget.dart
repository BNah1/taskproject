import 'package:flutter/material.dart';
import 'package:taskproject/core/utils/mock_utils.dart';
import 'package:taskproject/feature/task/view/widget/task_tile.dart';
import 'package:taskproject/model/task_model.dart';

class ListTaskWidget extends StatelessWidget {
  const ListTaskWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getListTask(),
        builder: (context, snapshot){
          List<TaskModel> list = [];
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No tasks found.'));
          } else {
            list = snapshot.data!;
          }
          return ListView.builder(
              padding: EdgeInsets.zero,
              scrollDirection: Axis.vertical,
              itemCount: list.length,
              itemBuilder: (context, index){
            return TaskTile(task: list[index],);
          });
        });
  }
}
