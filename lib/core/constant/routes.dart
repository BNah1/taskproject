import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taskproject/feature/chat/sub_view/chat_box_view.dart';
import 'package:taskproject/feature/chat/sub_view/info_user_chat_view.dart';
import 'package:taskproject/feature/chat/sub_view/searching_chat_view.dart';
import 'package:taskproject/feature/home/view/home_view.dart';
import 'package:taskproject/feature/login/view/on_boarding.dart';
import 'package:taskproject/feature/task/view/task_view.dart';
import 'package:taskproject/model/task_model.dart';
import 'package:taskproject/model/user_model.dart';





class AppRoutes {

  ///Route name
  static const String home = '/home';
  static const String taskView = '/taskView';
  static const String onBoarding = '/onBoarding';
  static const String chatBox = '/chatBox';
  static const String userInfoChat = '/userInfoChat';
  static const String searchChat = '/searchChat';

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

      case userInfoChat:
        final userId = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => InfoUserChatView(userId: userId,),
        );

      case searchChat:
        final user = settings.arguments as UserModel;
        return MaterialPageRoute(
          builder: (_) => SearchingChatView(user: user,),
        );

      case chatBox:
        final userId = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => ChatBoxView(userId: userId),
        );

      case onBoarding:
        return  _cupertinoRoute(
          const OnBoardingView(),
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