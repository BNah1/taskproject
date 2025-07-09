import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:taskproject/core/constant/app_enum.dart';
import 'package:taskproject/core/constant/app_style.dart';
import 'package:taskproject/core/utils/toast_utils.dart';
import 'package:taskproject/core/utils/snapshot_utils.dart';
import 'package:taskproject/feature/login/state/auth_state.dart';
import 'package:taskproject/feature/project/state/project_controller_model.dart';
import 'package:taskproject/feature/project/state/project_state.dart';
import 'package:taskproject/feature/project/view/widget/project_create_widget.dart';
import 'package:taskproject/feature/project/view/widget/project_detail_widget.dart';
import 'package:taskproject/model/project_model.dart';

class ListProject extends StatefulWidget {
  const ListProject({
    super.key,
    required this.title,
    required this.typeProject,
  });

  final String title;
  final TypeProject typeProject;

  @override
  State<ListProject> createState() => _ListProjectState();
}

class _ListProjectState extends State<ListProject> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            ///
            _headerColumn(title: widget.title, typeProject: widget.typeProject),

            ///
            const SizedBox(height: 10),
            _listProject(),
          ],
        ),
      ),
    );
  }

  Widget _listProject() {
    final int addCart = widget.typeProject == TypeProject.todo ? 1 : 0;
    return BlocBuilder<ProjectCubit, ProjectControllerModel>(
      builder: (context, state) {
        final List<ProjectModel> list;
        final user = context.watch<AuthenticationCubit>().state.userModel!;
        list = state
            .getListByType(widget.typeProject)
            .where(
              (e) => e.taskAssigned.contains(user) || e.taskCreatedBy == user,
            )
            .toList();
        return handleWidget(state, () {
          return DragTarget<ProjectModel>(
            onWillAcceptWithDetails: (data) => true,
            onAcceptWithDetails: (projectDetails) {
              final project = projectDetails.data;

              if (!list.contains(project)) {
                context.read<ProjectCubit>().updateProject(
                  projectId: project.projectId,
                  typeProcess: widget.title,
                );
              }
            },
            builder: (context, candidateData, rejectedData) {
              if (list.isEmpty) {
                return widget.typeProject == TypeProject.todo
                    ? Column(
                        children: [
                          const Center(
                            child: Text(
                              'Empty List',
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                          ),
                          const SizedBox(height: 10),
                          _buttonAdd(),
                        ],
                      )
                    : const Padding(
                      padding:  EdgeInsets.symmetric(vertical: AppSize.paddingDashBoard*2),
                      child: Center(
                          child: Text(
                            'Empty List',
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                        ),
                    );
              }
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: list.length + addCart,
                itemBuilder: (context, index) {
                  if (widget.typeProject == TypeProject.todo &&
                      index == list.length) {
                    return _buttonAdd();
                  }

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: _buildDraggableCard(list[index]),
                  );
                },
              );
            },
          );
        });
      },
    );
  }

  Widget _buttonAdd() {
    return InkWell(
      onTap: () {
        showModal(context, const ProjectCreateWidget());
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12.0),
        child: DottedBorder(
          borderType: BorderType.RRect,
          radius: const Radius.circular(5),
          color: Colors.black,
          strokeWidth: 1,
          dashPattern: const [4, 5],
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            color: Colors.grey[100],
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.add, color: Colors.black),
                  Text(
                    'Add card',
                    style: AppTextStyle.textTitleTask(Colors.black),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _headerColumn({
    required String title,
    required TypeProject typeProject,
  }) {
    final color = ColorPool(AppColor.taskColors).getNext();
    final user = context.watch<AuthenticationCubit>().state.userModel!;
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
              ///
              Text(title, style: AppTextStyle.textBodyTile()),
              const SizedBox(width: 5),

              ///
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.brown),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: BlocBuilder<ProjectCubit, ProjectControllerModel>(
                  builder: (context, state) {
                    if (state.status == BaseStatus.loaded) {
                      final length = state
                          .getListByType(widget.typeProject)
                          .where(
                            (e) =>
                                e.taskAssigned.contains(user) ||
                                e.taskCreatedBy == user,
                          )
                          .toList()
                          .length;
                      return Text(
                        length.toString(),
                        style: const TextStyle(color: Colors.brown),
                      );
                    } else {
                      return const Text(
                        '-',
                        style: TextStyle(color: Colors.brown),
                      );
                    }
                  },
                ),
              ),
            ],
          ),

          ///
          SizedBox(
            width: 40,
            child: SvgPicture.asset(
              'assets/icons/menu-dots.svg',
              color: Colors.grey,
              fit: BoxFit.cover,
            ),
          ),
        ],
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
