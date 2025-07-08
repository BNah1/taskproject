import 'package:flutter/material.dart';
import 'package:taskproject/core/service/project_service.dart';
import 'package:taskproject/core/utils/snapshot_utils.dart';
import 'package:taskproject/feature/home/view/widget/project_tile.dart';


class ListProjectWidget extends StatelessWidget {
  const ListProjectWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: ProjectService().getListProject(),
        builder: (context, snapshot){
          return checkSnapShot(snapshot, (list){
            return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: list.length,
                itemBuilder: (context, index){
                  return ProjectTile(project: list[index],);
                });
          });
        });
  }
}
