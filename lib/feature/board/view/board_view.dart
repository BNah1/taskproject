import 'package:flutter/material.dart';
import 'package:taskproject/core/constant/app_style.dart';
import 'package:taskproject/core/mock/data.dart';
import 'package:taskproject/core/utils/valid_utils.dart';
import 'package:taskproject/feature/board/view/task_board_tile.dart';
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
    listTask = MockData.listTaskMock
        .where((e) => e.taskDeadLineMin.day == time.day)
        .toList()
      ..sort((a, b) => a.taskDeadLineMin.hour.compareTo(b.taskDeadLineMin.hour));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Schedule',style: AppTextStyle.dashboardTitle,)),
        actions: [
          Icon(Icons.menu)
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child:
        Padding(
          padding:  const EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${formatDateCalender(time)} v',style: AppTextStyle.textSubBodyProject(Colors.black),),
              Text('${listTask.length} Tasks Today', style: AppTextStyle.textHint(Colors.grey),),
              ///
              _listDay(),

              listDailyTask()

              ///
              ///
              ///
            ],
          ),
        ),
      ),
    );
  }

  Widget _listDay(){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: SizedBox(
        height: 100,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 10,
          itemBuilder: (context, index) {
            final date = time.add(Duration(days: index - 5));
            final day = formatDateDay(date);
            final weekday = formatDateWeekDay(date);

            final isToday = date.day == time.day &&
                date.month == time.month &&
                date.year == time.year;

            return InkWell(
              onTap: (){
                setState(() {
                  time = date;
                });
              },
              child: Container(
                width: 70,
                margin: const EdgeInsets.symmetric(horizontal: 6),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: isToday ? Colors.blueAccent : Colors.grey[200],
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Column(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          day,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: isToday ? Colors.white : Colors.black,
                          ),
                        ),
                        Text(
                          weekday,
                          style: TextStyle(
                            color: isToday ? Colors.white : Colors.black,
                          ),
                        ),
                        isToday ?  Center(child: Text('*',style: AppTextStyle.textHint(Colors.white),)) : const SizedBox.shrink()
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
  
  
  Widget listDailyTask(){
    return Column(
      children: listTask.map((e) => TaskBoardTile(task: e)).toList(),
    );
  }


}
