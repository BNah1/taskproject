import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taskproject/core/constant/app_style.dart';
import 'package:taskproject/core/widget/container_tile_widget.dart';
import 'package:taskproject/core/widget/list_user_tile_widget.dart';
import 'package:taskproject/model/project_model.dart';

class ProjectDetailWidget extends StatelessWidget {
  const ProjectDetailWidget({super.key, required this.project});

  final ProjectModel project;

  @override
  Widget build(BuildContext context) {
    return ContainerCustomTile(color: Colors.white, paddingInside: 5, child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(project.projectName,style: AppTextStyle.textBodyTile,),
        SizedBox(height: 10),
        Text(project.description,style: AppTextStyle.textHint(Colors.grey),),
        SizedBox(height: 10),
        ///
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
               Text('Progress',style: AppTextStyle.textHint(Colors.black)),
              Text('${(project.listTask.length * project.progress).round()}/${project.listTask.length}',style: AppTextStyle.textHint(Colors.black)),
            ]),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: SizedBox(
            width: MediaQuery.of(context).size.width*0.8-10,
            child: LinearProgressIndicator(
              value: project.progress,
              minHeight: 5,
              backgroundColor: Colors.grey[300],
              color: Colors.green,
            ),
          ),
        ),
        ///
        const Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Icons.add_alert),
              Icon(Icons.add_alert),
              Icon(Icons.add_alert),
            ]),
        SizedBox(height: 10),
        ///
        Row(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              listUser(project.taskAssigned),
              SizedBox(width: 10,),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.grey[350]
                ),
                padding: EdgeInsets.all(5),
                child: Text(project.urgent),
              )
            ]),      ],
    ));
  }
}
