import 'package:flutter/material.dart';
import 'package:taskproject/feature/board/view/board_view.dart';
import 'package:taskproject/feature/home/view/dash_board_view.dart';

class AppTab{

  static List<Widget> listTabView = [
    const DashBoardView(),
    const BoardView(),
    Container(color: Colors.blue,),
    Container(color: Colors.yellow,),
  ];

  static TabBarView tabView(TabController tabController){
    return TabBarView(
      controller: tabController,
      children: listTabView
    );
  }

  static List<Tab> getHomeScreenTabs(int index) {
    return [
      Tab(
        // iconMargin: const EdgeInsets.only(top: AppSize.paddingMenu),
        text: 'Home',
        icon: Icon(
          index == 0 ? Icons.home : Icons.home_outlined,
        ),
      ),
      Tab(
        // iconMargin: const EdgeInsets.only(top: AppSize.paddingMenu),
        text: 'Board',
        icon: Icon(
          index == 1 ? Icons.developer_board : Icons.developer_board_outlined,
        ),
      ),
      Tab(
        // iconMargin: const EdgeInsets.only(top: AppSize.paddingMenu),
        text: 'Messages',
        icon: Icon(
          index == 2 ? Icons.message : Icons.message_outlined,
        ),
      ),
      Tab(
        // iconMargin: const EdgeInsets.only(top: AppSize.paddingMenu),
        text: 'Setting',
        icon: Icon(
          index == 3 ? Icons.settings : Icons.settings_outlined,
        ),
      ),
    ];
  }
}