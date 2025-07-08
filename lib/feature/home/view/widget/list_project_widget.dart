import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskproject/core/utils/snapshot_utils.dart';
import 'package:taskproject/feature/home/view/widget/project_tile.dart';
import 'package:taskproject/feature/login/state/auth_state.dart';
import 'package:taskproject/feature/project/state/project_controller_model.dart';
import 'package:taskproject/feature/project/state/project_state.dart';

class ListProjectWidget extends StatelessWidget {
  const ListProjectWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectCubit, ProjectControllerModel>(
      builder: (context, state) {
        return handleWidget(state, () {
          final user = context.watch<AuthenticationCubit>().state.userModel!;
          final list = state.listProjectById(user);
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: list.length,
            itemBuilder: (context, index) {
              return ProjectTile(project: list[index]);
            },
          );
        });
      },
    );
  }
}
