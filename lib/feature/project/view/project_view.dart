import 'package:flutter/material.dart';
import 'package:taskproject/core/mock/data.dart';
import 'package:taskproject/core/utils/mock_utils.dart';
import 'package:taskproject/feature/project/view/widget/project_detail_widget.dart';
import 'package:taskproject/model/project_model.dart';

class ProjectView extends StatefulWidget {
  const ProjectView({super.key});


  @override
  State<ProjectView> createState() => _ProjectViewState();
}

class _ProjectViewState extends State<ProjectView> {
  List<ProjectModel> listA = [];
  List<ProjectModel> listB = [];

  @override
  void initState() {
    listA = MockData.listProjectMock.where((e) => e.type == "IN WORK").toList();
    listB = MockData.listProjectMock.where((e) => e.type == "COMPLETE").toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('asdasd'),
      ),
      body:  SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          SizedBox(
            width: size.width * 0.8,
            child: buildDragColumn("IN WORK", listA, listB, true),
          ),
          SizedBox(
            width: size.width * 0.8,
            child: buildDragColumn("COMPLETE", listA, listB, false),
          ),
        ],
      ),
    )
    );
  }

  Widget buildDragColumn(String title, List<ProjectModel> listA, List<ProjectModel> listB, bool inWork ) {
    final int addCart = !inWork ? 0 : 1;
    return DragTarget<ProjectModel>(
      onWillAccept: (data) => true,
      onAccept: (project) {
        setState(() {
          listB.remove(project);
          if (!listA.contains(project)) {
            project.type = title;
            listA.add(project);
          }
        });
      },
      builder: (context, candidateData, rejectedData) {
        return Container(
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
          Expanded(
          child: ListView.builder(
            itemCount: listA.length + addCart,
            itemBuilder: (context, index) {
              if (inWork && index == listA.length) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: InkWell(
                    onTap: () {
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Center(
                        child: Text(
                          '+ Add card',
                          style: TextStyle(color: Colors.blueAccent),
                        ),
                      ),
                    ),
                  ),
                );
              }

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: _buildDraggableCard(listA[index]),
              );
            },

          ),
        ),
            ],
          ),
        );
      },
    );
  }



  Widget _buildDraggableCard(ProjectModel project) {
    return Draggable<ProjectModel>(
      data: project,
      feedback: Material(
        color: Colors.transparent,
        child: Opacity(
          opacity: 0.8,
          child: ProjectDetailWidget(project: project),
        ),
      ),
      childWhenDragging: Opacity(
        opacity: 0.5,
        child: ProjectDetailWidget(project: project),
      ),
      child: ProjectDetailWidget(project: project),
    );
  }

}
