import 'package:flutter/material.dart';
import 'package:taskproject/core/constant/app_style.dart';
import 'package:taskproject/core/constant/routes.dart';

class SettingView extends StatelessWidget {
  const SettingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Setting')),
      body: Column(
        children: [
          TextButton(
            onPressed: () {
              Navigator.of(
                context,
                rootNavigator: true,
              ).pushReplacementNamed(AppRoutes.onBoarding);
            },
            child: Center(
              child: Text('LOG OUT', style: AppTextStyle.dashboardWelcome),
            ),
          ),
        ],
      ),
    );
  }
}
