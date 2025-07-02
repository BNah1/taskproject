import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taskproject/core/utils/valid_utils.dart';
import 'package:taskproject/model/task_model.dart';

class TaskBoardTile extends StatelessWidget {
  TaskBoardTile({super.key, required this.task});

  final TaskModel task;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _timeTile(),
          const SizedBox(width: 10),
          Expanded(child: _taskDetail()),
        ],
      ),
    );
  }

  Widget _timeTile() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 10),
        Text(formatDateHour(task.taskDeadLineMin)),
        SizedBox(height: 10),
        Text(formatDateHour(task.taskDeadLineMax)),
      ],
    );
  }

  Widget _taskDetail() {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.grey,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(task.taskName),
          Text(task.urgent),
          Row(
            children: [
              const Icon(Icons.lock_clock),
              const SizedBox(width: 5),
              Text(
                '${formatDateHour(task.taskDeadLineMin)} - ${formatDateHour(task.taskDeadLineMax)}',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
