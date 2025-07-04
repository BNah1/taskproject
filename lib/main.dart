import 'package:flutter/material.dart';
import 'package:taskproject/core/di/init.dart';
import 'package:taskproject/feature/login/state/auth_state.dart';
import 'package:taskproject/feature/login/view/on_boarding.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/constant/routes.dart';

Future<void> main() async {
  await AppInit.init();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider.value(value: chatCubit),
        BlocProvider(create: (_) => AuthenticationCubit())
      ],
      child: const MyApp(),
    ),
  );
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

