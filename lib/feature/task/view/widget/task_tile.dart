import 'package:flutter/material.dart';
import 'package:taskproject/core/constant/app_style.dart';
import 'package:taskproject/core/constant/routes.dart';
import 'package:taskproject/core/utils/valid_utils.dart';
import 'package:taskproject/core/widget/list_user_tile_widget.dart';
import 'package:taskproject/model/task_model.dart';

class TaskTile extends StatefulWidget {
  const TaskTile({super.key, required this.task});

  final TaskModel task;

  @override
  State<TaskTile> createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  bool ticked = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSize.paddingMenu),
      child: Container(
        margin: ticked
            ? const EdgeInsets.all(AppSize.paddingMenu)
            : const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSize.paddingMenu,
          vertical: AppSize.paddingDashBoard + 5,
        ),
        decoration: BoxDecoration(
          color: ticked ? Colors.white70 : Colors.white,
          borderRadius: BorderRadius.circular(AppSize.borderTile),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Checkbox(
              activeColor: Colors.green,
              shape: const CircleBorder(),
              side: const BorderSide(color: Colors.green, width: 2),
              value: ticked,
              onChanged: (value) {
                print(value);
                setState(() {
                  if (value != null) {
                    ticked = value;
                  }
                });
              },
            ),
            const SizedBox(width: AppSize.paddingDashBoard),
            Expanded(
              child: InkWell(
                onTap: () {
                  Navigator.of(
                    context,
                    rootNavigator: true,
                  ).pushNamed(AppRoutes.taskView, arguments: widget.task);
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.task.taskName,
                      style: AppTextStyle.textSubBodyProject(Colors.black),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      formatDate(widget.task.taskDeadLineMin),
                      style: AppTextStyle.textSubBody,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 50, child: listUser(widget.task.taskAssigned)),
            const SizedBox(width: AppSize.paddingDashBoard),
          ],
        ),
      ),
    );
  }
}
