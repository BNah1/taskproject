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
    final color = colorPool.getNext();
    return ContainerCustomTile(color: Colors.white, paddingInside: AppSize.paddingDashBoard, child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ///
        Container(
          padding: const EdgeInsets.symmetric(vertical: 3, horizontal: AppSize.paddingDashBoard),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(20)
          ),
          child: Text(project.type),
        ),
        ///
        Text(project.projectName,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyle.textBodyTile(),),
        const SizedBox(height: 10),
        Text(project.description,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyle.textBodyTile(color: AppColor.projectTileAll, fontWeight: FontWeight.normal, size: AppSize.textSizeSubBody),),
        const SizedBox(height: 10),
        ///
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
               Text('Progress',style: AppTextStyle.textBodyTile(size: AppSize.textSizeSubBody, color: Colors.brown)),
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
         Row(
            children: [
              _iconTile(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: _iconTile(),
              ),
              _iconTile(),
            ]),
        const SizedBox(height: 10),
        ///
        Row(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              listUser(project.taskAssigned),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: color
                ),
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                child: Text(project.urgent),
              )
            ]),      ],
    ));
  }
  
  Widget _iconTile(){
    return const Row(children: [
      Icon(Icons.add_alert,color: Colors.grey,),
      Text('5',style: TextStyle(color: Colors.grey),)
    ],);
  }
}
