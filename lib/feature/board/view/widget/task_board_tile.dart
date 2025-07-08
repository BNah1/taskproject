import 'package:flutter/material.dart';
import 'package:taskproject/core/constant/app_style.dart';
import 'package:taskproject/core/utils/valid_utils.dart';
import 'package:taskproject/core/widget/list_user_tile_widget.dart';
import 'package:taskproject/model/task_model.dart';

class TaskBoardTile extends StatelessWidget {
  const TaskBoardTile({super.key, required this.task});

  final TaskModel task;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
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
      ),
    );
  }

  Widget _timeTile() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: AppSize.paddingDashBoard),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(formatDateHour(task.taskDeadLineMin),style:  AppTextStyle.textBodyTask(Colors.brown)),
          Text(formatDateHour(task.taskDeadLineMax),style:  AppTextStyle.textBodyTask(Colors.brown)),
        ],
      ),
    );
  }

  Widget _taskDetail() {
    final randomColor = ColorPool(AppColor.taskColors).getNext();
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: randomColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(task.taskName, style: AppTextStyle.textTitleTask(AppColor.taskTileBoard),),
          const SizedBox(height: 5),
          Text(task.taskTypeProgress,style: AppTextStyle.textBodyTask(AppColor.taskTileBoard)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(children: [Icon(Icons.lock_clock, color: AppColor.taskTileBoard,),
                const SizedBox(width: 5),
                Text(
                  '${formatDateHour(task.taskDeadLineMin)} - ${formatDateHour(task.taskDeadLineMax)}',style: AppTextStyle.textBodyTask(AppColor.taskTileBoard),
                ),],),
              listUser(task.taskAssigned)
            ],
          ),
        ],
      ),
    );
  }
}
