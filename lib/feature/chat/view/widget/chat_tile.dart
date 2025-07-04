import 'package:flutter/material.dart';
import 'package:taskproject/core/constant/routes.dart';
import 'package:taskproject/core/utils/mock_utils.dart';
import 'package:taskproject/core/utils/snapshot_utils.dart';
import 'package:taskproject/core/utils/valid_utils.dart';

class ChatTile extends StatelessWidget {
  const ChatTile({
    super.key,
    required this.userId,
    required this.lastMessage,
    required this.lastMessageTs,
    required this.chatroomId,
  });

  final String userId;
  final String lastMessage;
  final DateTime lastMessageTs;
  final String chatroomId;

  @override
  Widget build(BuildContext context) {
    final user = getUser(userId);
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 8.0,
      ),
      child: InkWell(
        onTap: () {
          print('asdsad');
          Navigator.of(context, rootNavigator: true).pushNamed(
              AppRoutes.chatBox,
              arguments: user.id
          );
        },
        child: Row(
          children: [
            // Profile Pic
            CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage(user.pathImage),
            ),
            const SizedBox(width: 10),
            // Column (Name + Last Message + Last Message Timestamp)
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name
                  Text(
                    user.userName,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 5),
                  // Last Message + Timestamp
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          lastMessage,
                          style: const TextStyle(
                            color: Colors.grey,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const Text(' → '),
                      Text(
                        formatDate(lastMessageTs),
                        style: const TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Message status
            const Padding(
              padding: EdgeInsets.only(left: 10),
              child: Icon(
                Icons.check_circle_outline,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
