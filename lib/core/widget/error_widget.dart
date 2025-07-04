import 'package:flutter/material.dart';
import 'package:taskproject/core/constant/app_style.dart';
import 'package:taskproject/core/widget/container_tile_widget.dart';

class ErrorWidget extends StatelessWidget {
  const ErrorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const ContainerCustomTile(color: Colors.white,
        paddingInside: 40,
        child: Center(child: Text('ERROR'),));
  }
}
