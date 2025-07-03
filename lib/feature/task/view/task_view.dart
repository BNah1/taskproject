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
        title: Text(AppString.titleTaskView,style: AppTextStyle.textBodyTile(),),
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
            ContainerCustomTile(paddingInside: 30,color: Colors.white, child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [

                //title
                Text(widget.task.taskName,style: AppTextStyle.textBodyTile()),
                Text(widget.task.taskName,style: AppTextStyle.textBodyTile(size: AppSize.textSizeSubBody, color: Colors.grey)),
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
        Text('Team',style: AppTextStyle.textBodyTile(size: AppSize.textSizeSubBody, color: Colors.grey)),
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
                border: Border.all(color: Colors.black12, width: 2),
                color: Colors.white,
              ),
              child: const Center(
                child: Icon(Icons.add, color: Colors.blue,)
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
            Text('My Projects',style: AppTextStyle.textBodyTile(size: AppSize.textSizeSubBody, color: Colors.grey),),
            const SizedBox(height: 10,),
            Text('${widget.task.subTasks.length} tasks', style: AppTextStyle.textBodyTile(size: AppSize.textSizeSubBody, color: Colors.blueGrey),)
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
            const SizedBox(height: AppSize.paddingDashBoard,),
            Text('Deadline',style: AppTextStyle.textBodyTile(size: AppSize.textSizeSubBody, color: Colors.grey)),
            const SizedBox(height: 10,),
            _timeTile(Icons.lock_clock, '${formatDateHour(widget.task.taskDeadLineMin)} - ${formatDateHour(widget.task.taskDeadLineMax)}'),
            const SizedBox(height: 10,),
            _timeTile(Icons.calendar_month_sharp, formatDateCalender(widget.task.taskDeadLineMin))
          ],
        ),

        SizedBox(
          height: 80,
          width: 80,
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                height: 80,
                width: 80,
                child: CircularProgressIndicator(
                  value: widget.task.progress,
                  strokeWidth: 8,
                  backgroundColor: Colors.grey[300],
                  color: Colors.blueAccent,
                ),
              ),
              Text('${(widget.task.progress * 100).round()}%',style: AppTextStyle.textBodyTile(),),
            ],
          ),
        )

      ],
    );
  }


  Widget _timeTile(IconData icon, String text){
    return Row(
      children: [
        Icon(icon, color: Colors.blueGrey,),
        const SizedBox(width: AppSize.paddingMenu,),
        Text(text, style:  AppTextStyle.textBodyTile(size: AppSize.textSizeSubBody, color: Colors.blueGrey),)
      ],
    );
  }


  Widget _bottomTile(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Description',style: AppTextStyle.textBodyTile()),
        const SizedBox(height: AppSize.paddingMenu,),
        Text(widget.task.descriptions,style: AppTextStyle.textBodyTile(size: AppSize.textSizeSubBody, color: Colors.grey),),
        const SizedBox(height: AppSize.paddingDashBoard,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('SubTask',style: AppTextStyle.textBodyTile(),),
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
