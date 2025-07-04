import 'package:flutter/material.dart';
import 'package:taskproject/feature/login/view/on_boarding.dart';

import 'core/constant/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const OnBoardingView(),
      onGenerateRoute: AppRoutes.onGenerateRoute,
    );
  }
}

