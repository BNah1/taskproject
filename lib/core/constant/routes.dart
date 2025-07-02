import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taskproject/feature/home/view/home_view.dart';
import 'package:taskproject/feature/task/view/task_view.dart';
import 'package:taskproject/model/task_model.dart';





class AppRoutes {

  ///Route name
  static const String home = '/home';
  static const String taskView = '/taskView';

  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return _cupertinoRoute(
          const HomeView(),
        );
      case taskView:
        final task = settings.arguments as TaskModel;
        return MaterialPageRoute(
          builder: (_) => TaskView(task: task),
        );

      default:
        return _cupertinoRoute(Scaffold(
          body: Center(
            child: Text(
              'Wrong Route provided ${settings.name}',
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ));
    }
  }

  static Route _cupertinoRoute(Widget view) => CupertinoPageRoute(
    builder: (_) => view,
  );

  AppRoutes._();
}