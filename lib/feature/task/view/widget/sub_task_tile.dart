import 'package:flutter/material.dart';
import 'package:taskproject/core/constant/app_style.dart';

class SubTaskTile extends StatefulWidget {
  const SubTaskTile({super.key, required this.subTask});

  final String subTask;

  @override
  State<SubTaskTile> createState() => _SubTaskTileState();
}

class _SubTaskTileState extends State<SubTaskTile> {
  bool ticked = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSize.paddingDashBoard),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Checkbox(
            activeColor: Colors.green,
            shape: const CircleBorder(),
            value: ticked,
            onChanged: (value) {
              print(value);
              setState(() {
                if(value != null) {
                  ticked = value;
                }
              });
            },
          ),
          const SizedBox(width: AppSize.paddingDashBoard,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.subTask,
                  style: AppTextStyle.textHint(Colors.black),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],),
    );
  }



}
