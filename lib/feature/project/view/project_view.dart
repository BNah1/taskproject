import 'package:flutter/material.dart';
import 'package:taskproject/core/constant/app_enum.dart';
import 'package:taskproject/feature/project/view/widget/list_project_widget.dart';

class ProjectView extends StatefulWidget {
  const ProjectView({super.key});

  @override
  State<ProjectView> createState() => _ProjectViewState();
}

class _ProjectViewState extends State<ProjectView> {

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(title: const Text('All of my projects')),
      body: _bodyWidget(size)
    );
  }

  Widget _bodyWidget(Size size){
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          SizedBox(
            width: size.width * 0.7,
            child: const ListProject(typeProject: TypeProject.todo, title: 'TODO',),
          ),
          SizedBox(
            width: size.width * 0.7,
            child: const ListProject(typeProject: TypeProject.inWork, title: 'IN WORK',),
          ),
          SizedBox(
            width: size.width * 0.7,
            child: const ListProject(typeProject: TypeProject.complete, title: 'COMPLETE',),
          ),
        ],
      ),
    );
  }
}
