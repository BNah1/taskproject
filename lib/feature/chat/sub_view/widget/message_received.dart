import 'package:flutter/material.dart';
import 'package:taskproject/core/utils/mock_utils.dart';
import 'package:taskproject/core/utils/valid_utils.dart';
import 'package:taskproject/feature/chat/sub_view/widget/round_profile_tile.dart';
import 'package:taskproject/model/message_model.dart';

import 'message_content.dart';


class MessageReceived extends StatelessWidget {
  const MessageReceived({super.key, required this.message});

  final Message message;

  @override
  Widget build(BuildContext context) {
    String userId = message.senderId;
    String path = getUserPathImage(userId);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          RoundProfileTile(path: path,),
          const SizedBox(width: 15),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(12.0),
                  decoration: const BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: MessageContents(message: message),
                ),
                Text(formatDateHour(message.timestamp))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
