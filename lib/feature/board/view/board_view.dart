import 'package:flutter/material.dart';
import 'package:taskproject/core/constant/app_style.dart';
import 'package:taskproject/core/mock/data.dart';
import 'package:taskproject/core/utils/valid_utils.dart';
import 'package:taskproject/core/widget/container_tile_widget.dart';
import 'package:taskproject/feature/board/view/widget/task_board_tile.dart';
import 'package:taskproject/model/task_model.dart';

class BoardView extends StatefulWidget {
  const BoardView({super.key});

  @override
  State<BoardView> createState() => _BoardViewState();
}

class _BoardViewState extends State<BoardView> {
  DateTime time = DateTime.now();
  List<TaskModel> listTask = [];

  @override
  void initState() {
    updateListTask();
    super.initState();
  }

  void updateListTask() {
    listTask =
        MockData.listTaskMock
            .where((e) => e.taskDeadLineMin.day == time.day)
            .toList()
          ..sort(
            (a, b) => a.taskDeadLineMin.hour.compareTo(b.taskDeadLineMin.hour),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_circle_left_sharp),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Center(
          child: Text('Schedule', style: AppTextStyle.dashboardTitle),
        ),
        actions: const [Padding(
          padding: EdgeInsets.only(right: 40.0),
          child: Icon(Icons.menu),
        ), ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              _scheduleTile(),

              ///
              Text(
                'Daily Task',
                style: AppTextStyle.textBodyTile(fontWeight: FontWeight.bold),
              ),
              listDailyTask(),

              ///
              ///
              ///
            ],
          ),
        ),
      ),
    );
  }

  Widget _scheduleTile(){
    return ContainerCustomTile(
      color: Theme.of(context).scaffoldBackgroundColor,
      paddingInside: AppSize.paddingDashBoard,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _topScheduleTile(),
          Text(
            '${listTask.length} Tasks Today',
            style: AppTextStyle.textBodyTask(Colors.grey),
          ),

          ///
          const SizedBox(height: AppSize.paddingDashBoard),
          _listDay(),
        ],
      ),
    );
  }

  Widget _topScheduleTile(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
       Row(children: [
        Text(
          formatDateCalender(time),
          style: AppTextStyle.textTitleTask(Colors.black),
        ),
         const Icon(Icons.keyboard_arrow_down, size: 35,)
      ],),
      const Icon(Icons.calendar_month, color: Colors.blue,)
    ],);
  }


  Widget _listDay() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: SizedBox(
        height: 90,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 10,
          itemBuilder: (context, index) {
            final date = time.add(Duration(days: index - 5));
            final day = formatDateDay(date);
            final weekday = formatDateWeekDay(date);

            final isToday =
                date.day == time.day &&
                date.month == time.month &&
                date.year == time.year;

            return InkWell(
              onTap: () {
                setState(() {
                  time = date;
                  updateListTask();
                });
              },
              child: Stack(
                children: [
                  Container(
                    width: 60,
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      color: isToday ? Colors.blueAccent : Colors.grey[200],
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              day,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: isToday ? Colors.white : Colors.black,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              weekday,
                              style: TextStyle(
                                color: isToday ? Colors.white : Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  isToday
                      ? const Positioned(
                          bottom: 10,
                          right: 0,
                          left: 0,
                          child: Center(
                            child: CircleAvatar(radius: 3,
                            backgroundColor: Colors.white,),
                          ),
                        )
                      : const SizedBox.shrink(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget listDailyTask() {
    if (listTask.isEmpty) return const Center(child: Text('empty'));

    List<Widget> widgets = [];

    for (int i = 0; i < listTask.length; i++) {
      final current = listTask[i];
      widgets.add(TaskBoardTile(task: current));

      if (i < listTask.length - 1) {
        final next = listTask[i + 1];
        final currentMax = current.taskDeadLineMax;
        final nextMin = next.taskDeadLineMin;

        final difference = nextMin.difference(currentMax).inHours;

        if (difference >= 3) {
          final timeMin = currentMax.add(const Duration(hours: 1));
          final timeMax = nextMin.subtract(const Duration(hours: 1));
          widgets.add(
            _emptyTile(formatDateHour(timeMin), formatDateHour(timeMax)),
          );
        } else if (difference > 0) {
          final middle = currentMax.add(Duration(hours: difference ~/ 2));
          widgets.add(
            _emptyTile(formatDateHour(middle), formatDateHour(middle)),
          );
        }
      }
    }

    return Column(children: widgets);

    // return listTask.isEmpty ? const Center(child: Text('empty')) : Column(
    //   children: listTask.map((e) => TaskBoardTile(task: e)).toList(),
    // );
  }

  Widget _timeTile(String timeMin, String timeMax) {
    return Container(
      child: timeMin == timeMax
          ? Text(timeMin, style: AppTextStyle.textBodyTask(Colors.brown))
          : Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(timeMin, style: AppTextStyle.textBodyTask(Colors.brown)),
                Text(timeMax, style: AppTextStyle.textBodyTask(Colors.brown)),
              ],
            ),
    );
  }

  Widget _emptyTile(String timeMin, String timeMax) {
    final height = MediaQuery.of(context).size.height;
    final bool = timeMin == timeMax;
    return SizedBox(
      height: bool ? 50 : height / 8,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _timeTile(timeMin, timeMax),
            const SizedBox(width: 10),
            Flexible(
              child: Stack(
                alignment: Alignment.centerLeft,
                children: [
                  LinearProgressIndicator(
                    value: 0,
                    minHeight: 4,
                    backgroundColor: Colors.grey[300],
                    color: Colors.green,
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Icon(Icons.change_circle, color: Colors.blue,),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
