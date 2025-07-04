import 'package:flutter/material.dart';


class RoundProfileTile extends StatelessWidget {
  const RoundProfileTile({
    super.key, required this.path,
  }
  );
  final String path;


  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
      ),
      child:CircleAvatar(
        radius: 20,
        backgroundImage: AssetImage(path),
      ),
    );
  }
}