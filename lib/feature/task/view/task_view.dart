import 'package:flutter/material.dart';
import 'package:taskproject/core/constant/app_string.dart';
import 'package:taskproject/core/constant/app_style.dart';
import 'package:taskproject/core/utils/valid_utils.dart';
import 'package:taskproject/core/widget/container_tile_widget.dart';
import 'package:taskproject/core/widget/list_user_tile_widget.dart';
import 'package:taskproject/feature/task/view/widget/sub_task_tile.dart';
import 'package:taskproject/model/task_model.dart';

class TaskView extends StatefulWidget {
  const TaskView({super.key, required this.task});

  final TaskModel task;

  @override
  State<TaskView> createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppString.titleTaskView,style: AppTextStyle.textBodyTile,),
        actions: const [Padding(
          padding: EdgeInsets.only(right: AppSize.paddingDashBoard),
          child: Icon(Icons.menu),
        )],
      ),

      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: AppSize.paddingDashBoard,),
            ContainerCustomTile(paddingInside: 20,color: Colors.white, child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [

                //title
                Text(widget.task.taskName,style: AppTextStyle.textBodyTile),
                Text(widget.task.taskName,style: AppTextStyle.textHint(Colors.grey)),
                const SizedBox(height: 10,),

                //
                _detailMiddle(),

                //
                _detailBottom(),
              ],
            )),

            //
            const SizedBox(height: AppSize.paddingDashBoard,),
            Padding(
              padding: const EdgeInsets.all(AppSize.paddingDashBoard),
              child: _bottomTile(),
            )
          ],
        ),
      ),
    );
  }

  Widget _teamTile(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Team',style: AppTextStyle.textSubBody),
        const SizedBox(height: 10,),
        Stack(children: [

          Row(children: [
            listUser(widget.task.taskAssigned),
            const SizedBox(width: 20,),
          ]),

          Positioned(
            right: 0,
            child: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey, width: 2),
                color: Colors.white,
              ),
              child: const Center(
                child: Text(
                  '+',
                  style: TextStyle(fontSize: 12, color: Colors.blueAccent),
                ),
              ),
            )

          ),
        ]),
      ],
    );
  }

  Widget _detailMiddle(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _teamTile(),

        Column(
          children: [
            Text('My Projects',style: AppTextStyle.textSubBody,),
            const SizedBox(height: 10,),
            Text('${widget.task.projectId} tasks')
          ],
        )
      ],
    );
  }

  Widget _detailBottom(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: AppSize.paddingMenu,),
            Text('Deadline',style: AppTextStyle.textSubBody),
            const SizedBox(height: 10,),
            _timeTile(Icons.lock_clock, '${formatDateHour(widget.task.taskDeadLineMin)} - ${formatDateHour(widget.task.taskDeadLineMax)}'),
            const SizedBox(height: 10,),
            _timeTile(Icons.calendar_month_sharp, formatDate(widget.task.taskDeadLineMin))
          ],
        ),

        SizedBox(
          height: 60,
          width: 60,
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                height: 60,
                width: 60,
                child: CircularProgressIndicator(
                  value: widget.task.progress,
                  strokeWidth: 6,
                  backgroundColor: Colors.grey[300],
                  color: Colors.blueAccent,
                ),
              ),
              Text('${(widget.task.progress * 100).round()}%',style: AppTextStyle.textSubBodyProject(Colors.black),),
            ],
          ),
        )

      ],
    );
  }


  Widget _timeTile(IconData icon, String text){
    return Row(
      children: [
        Icon(icon),
        const SizedBox(width: AppSize.paddingMenu,),
        Text(text)
      ],
    );
  }


  Widget _bottomTile(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Description',style: AppTextStyle.textBodyTile),
        const SizedBox(height: AppSize.paddingMenu,),
        Text(widget.task.descriptions,style: AppTextStyle.textHint(Colors.grey),),
        const SizedBox(height: AppSize.paddingDashBoard,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('SubTask',style: AppTextStyle.textBodyTile,),
            Text('+ Add task', style: AppTextStyle.dashboardAction,)
          ],
        ),
        const SizedBox(height: AppSize.paddingMenu,),
        listSubTasks()
      ],
    );
  }

  Widget listSubTasks(){
    return Column(
      children: widget.task.subTasks.map((e) => SubTaskTile(subTask: e)).toList(),
    );
  }

}
