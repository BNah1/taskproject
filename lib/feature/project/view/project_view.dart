import 'package:flutter/material.dart';
import 'package:taskproject/core/constant/app_style.dart';
import 'package:taskproject/core/mock/data.dart';
import 'package:taskproject/feature/project/view/widget/project_detail_widget.dart';
import 'package:taskproject/model/project_model.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
    listA = MockData.listProjectMock
        .where((e) => e.typeProcess == "IN WORK")
        .toList();
    listB = MockData.listProjectMock
        .where((e) => e.typeProcess == "COMPLETE")
        .toList();
    super.initState();
  }

  @override
  void dispose() {
    print('dispose test');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(title: const Text('All of my projects')),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            SizedBox(
              width: size.width * 0.7,
              child: buildDragColumn("IN WORK", listA, listB, true),
            ),
            SizedBox(
              width: size.width * 0.7,
              child: buildDragColumn("COMPLETE", listB, listA, false),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDragColumn(
    String title,
    List<ProjectModel> listA,
    List<ProjectModel> listB,
    bool inWork,
  ) {
    final int addCart = !inWork ? 0 : 1;
    return DragTarget<ProjectModel>(
      onWillAccept: (data) => true,
      onAccept: (project) {
        setState(() {
          listB.remove(project);
          if (!listA.contains(project)) {
            project.typeProcess = title;
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
              ///
              _headerColumn(title: title, length: listA.length),
              ///
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: listA.length + addCart,
                  itemBuilder: (context, index) {
                    if (inWork && index == listA.length) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: InkWell(onTap: () {}, child: _buttonAdd()),
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

  Widget _headerColumn({required String title, required int length}) {
    final color = ColorPool(AppColor.taskColors).getNext();
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: color, width: 3)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(title, style: AppTextStyle.textBodyTile()),
              const SizedBox(width: 5,),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.brown),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(length.toString(),style: const TextStyle(color:Colors.brown),),
              ),
            ],
          ),
          SizedBox(
              width: 40,
              child: SvgPicture.asset('assets/icons/menu-dots.svg',color: Colors.grey,fit: BoxFit.cover,))
        ],
      ),
    );
  }

  Widget _buttonAdd() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: DottedBorder(
        borderType: BorderType.RRect,
        radius: const Radius.circular(15),
        color: Colors.blueAccent,
        strokeWidth: 2,
        dashPattern: const [6, 4],
        // 6px line, 4px gap
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          color: Colors.grey[100], // màu nền trong viền
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.add, color: Colors.blue),
                const SizedBox(width: 10),
                Text('Add card', style: AppTextStyle.textTitleTask(Colors.brown)),
              ],
            ),
          ),
        ),
      ),
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
