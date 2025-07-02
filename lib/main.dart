import 'package:flutter/material.dart';

import 'core/constant/routes.dart';
import 'feature/home/view/home_view.dart';

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
      home: const HomeView(),
      onGenerateRoute: AppRoutes.onGenerateRoute,
    );
  }
}

