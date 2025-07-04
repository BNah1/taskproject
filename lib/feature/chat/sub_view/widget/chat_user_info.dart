import 'package:flutter/material.dart';
import 'package:taskproject/core/utils/mock_utils.dart';

class ChatUserInfo extends StatelessWidget {
  const ChatUserInfo({super.key, required this.userId});

  final String userId;

  @override
  Widget build(BuildContext context) {
    final user = getUser(userId);
    return Row(
      children: [
        CircleAvatar(
          radius: 20,
          backgroundImage: AssetImage(user.pathImage),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              user.userName,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            const Text(
              'Messenger',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      ],
    );
  }
}
