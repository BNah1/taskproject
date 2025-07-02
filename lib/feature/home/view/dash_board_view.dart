import 'package:flutter/material.dart';
import 'package:taskproject/core/constant/app_style.dart';
import 'package:taskproject/feature/home/view/widget/list_project_widget.dart';
import 'package:taskproject/feature/home/view/widget/profile_dashboard.dart';
import 'package:taskproject/feature/project/view/project_view.dart';
import 'package:taskproject/feature/task/view/widget/list_task_widget.dart';


class DashBoardView extends StatelessWidget {
  const DashBoardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSize.paddingDashBoard, horizontal: AppSize.paddingDashBoard),
      child: Column(
        children: [
          const SizedBox(
            height: 60,
          ),
          const ProfileDashBoard(),
          const SizedBox(
            height: 30,
          ),
          containTile(
              'Your project',
              const SizedBox(height: 250, child: ListProjectWidget()),
              'See all',
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute<void>(builder: (_) => const ProjectView()),
                    );
                  }),
          const SizedBox(height: 45,),
          Expanded(
            child: containTile(
                'Your tasks',
                const Expanded(child: ListTaskWidget()),
                'Add tasks',
                () {}),
          ),
        ],
      ),
    );
  }

  Widget containTile(
      String title, Widget child, String action, VoidCallback tap) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title,style: AppTextStyle.dashboardTitle,),
            InkWell(onTap: tap, child: Text(action,style: AppTextStyle.dashboardAction,)),
          ],
        ),
        const SizedBox(height: AppSize.paddingDashBoard,),
        child
      ],
    );
  }
}
