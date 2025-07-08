import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskproject/core/constant/app_style.dart';
import 'package:taskproject/feature/login/state/auth_state.dart';

class ProfileDashBoard extends StatelessWidget {
  const ProfileDashBoard({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthenticationCubit>().state.userModel!;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Hi, ${user.userName}',style:  AppTextStyle.dashboardWelcome,),
            Text('5 tasks for you today',style:  AppTextStyle.textHint(Colors.grey)),
          ],
        ),
        CircleAvatar(
          radius: 40,
          backgroundImage: AssetImage(user.pathImage),
        ),
      ],
    );
  }
}
