import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskproject/core/utils/mock_utils.dart';
import 'package:taskproject/core/utils/snapshot_utils.dart';
import 'package:taskproject/feature/login/state/auth_state.dart';
import 'package:taskproject/feature/task/state/task_controller_model.dart';
import 'package:taskproject/feature/task/state/task_state.dart';
import 'package:taskproject/feature/task/view/widget/task_tile.dart';
import 'package:taskproject/model/task_model.dart';

class ListTaskWidget extends StatelessWidget {
  const ListTaskWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskCubit,TaskControllerModel>(
        builder: (context,state) {
          return handleWidget(state, (){
            final user = context.watch<AuthenticationCubit>().state.userModel;
            final list = state.getListById(user!);
            return ListView.builder(
                padding: EdgeInsets.zero,
                scrollDirection: Axis.vertical,
                itemCount: list.length,
                itemBuilder: (context, index){
                  return TaskTile(task: list[index],);
                });
          });
        }
    );
  }
}
