import 'package:flutter/material.dart';
import 'package:taskproject/model/user_model.dart';

Widget listUser(List<UserModel> list) {
  const double avatarSize = 32;
  const double overlap = 20;

  final showCount = list.length > 2 ? 2 : list.length;
  final showList = list.sublist(0, showCount);
  final totalAvatars = list.length > 2 ? 2 : list.length;

  return SizedBox(
    height: avatarSize,
    width: totalAvatars * (avatarSize - overlap) + overlap*2,
    child: Stack(
      children: [
        for (int i = 0; i < showList.length; i++)
          Positioned(
            left: i * (avatarSize - overlap),
            // child: CircleAvatar(
            //   radius: avatarSize / 2,
            //   backgroundImage: AssetImage(showList[i].pathImage),
            // ),
            child: _circleTile(showList[i].pathImage, avatarSize),
          ),

        if (list.length > 2)
          Positioned(
            left: showCount * (avatarSize - overlap),
            child: CircleAvatar(
              radius: avatarSize / 2,
              backgroundColor: Colors.grey[50],
              child: Text(
                '+${list.length - 2}',
                style: const TextStyle(fontSize: 12, color: Colors.black),
              ),
            ),
          ),
      ],
    ),
  );

}

Widget _circleTile(String path, double radius){
  return Container(
    width: radius,
    height: radius,
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage(path),
        fit: BoxFit.cover,
      ),
      shape: BoxShape.circle,
      border: Border.all(color: Colors.white, width: 2),
      color: Colors.white,
    ),
  );
}