import 'package:flutter/material.dart';
import 'package:taskproject/core/constant/app_style.dart';
import 'package:taskproject/model/project_model.dart';
import 'package:taskproject/model/user_model.dart';


class ProjectTile extends StatelessWidget {
  const ProjectTile({super.key, required this.project});

  final ProjectModel project;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return _boxDecoration(_projectDetail(), size);
  }

  Widget _boxDecoration(Widget child, Size size){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSize.paddingDashBoard),
      child: Container(
        width: size.width/2 - 20,
        height: size.height/4 - 30,
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppSize.borderTile),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: child
      ),
    );
  }

  Widget _projectDetail(){
    return Column(
      children: [
        Expanded(
          child: _projectDetailTop()
        ),
        _projectDetailBot()
      ],
    );
  }

  Widget _projectDetailBot(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSize.paddingDashBoard),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: AppSize.paddingMenu),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                listUser(project.taskAssigned), Text('%${(project.progress*100).round()}',style: const TextStyle(fontWeight: FontWeight.bold),)
              ],
            ),
          ),

          ///
          const SizedBox(height: AppSize.paddingMenu,),
          LinearProgressIndicator(
            value: project.progress,
            minHeight: 5,
            backgroundColor: Colors.grey[300],
            color: Colors.green,
          ),
          const SizedBox(height: AppSize.paddingDashBoard,),
        ],
      ),
    );
  }

  Widget _projectDetailTop(){
    final randomColor = ColorPool(AppColor.taskColors).getNext();
    return Container(
      padding: const EdgeInsets.all(AppSize.paddingMenu),
      decoration: BoxDecoration(
        color: randomColor,
        image: const DecorationImage(
          image: AssetImage('assets/Backgrounds/Spline.png'),
          fit: BoxFit.cover,
        ),
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(AppSize.paddingDashBoard), topRight: Radius.circular(AppSize.paddingDashBoard),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: AppSize.paddingMenu,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSize.paddingMenu),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    padding: const EdgeInsets.all(AppSize.paddingMenu),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white24
                    ),
                    child: const Icon(Icons.search,color: Colors.white,)),
                const Text("' ' '", style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 30),),
              ],
            ),
          ),
          const SizedBox(height: AppSize.paddingDashBoard,),
          Text(project.projectName,style: AppTextStyle.textSubBodyProject(Colors.white70),maxLines: 1,
            overflow: TextOverflow.ellipsis,),
          Text('${project.listTask.length} tasks',style: AppTextStyle.textSubBodyProject(Colors.white)),
          const SizedBox(height: AppSize.paddingDashBoard,),
        ],),
    );
  }

  Widget listUser(List<UserModel> list){
    return Row(
      children: list.map((e) => CircleAvatar(
        radius: 15,
        backgroundImage: AssetImage(e.pathImage),
      )).toList(),
    );
  }
}
