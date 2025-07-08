import 'package:flutter/material.dart';
import 'package:taskproject/core/utils/valid_utils.dart';
import 'package:taskproject/model/message_model.dart';

import 'message_content.dart';


class MessageSent extends StatelessWidget {
  const MessageSent({super.key, required this.message});
  final Message message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const SizedBox(width: 15),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.all(12.0),
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(15),
                        topLeft: Radius.circular(20),
                        bottomLeft: Radius.circular(20)),
                  ),
                  child: Wrap(
                    children: [
                      MessageContents(
                        message: message,
                        isSentMessage: true,
                      ),
                      const SizedBox(width: 5),
                      message.seen
                          ? const Icon(
                        Icons.done_all,
                        color: Colors.white,
                      )
                          : const Icon(
                        Icons.check,
                        color: Colors.white,
                      ),
                    ],
                  ),
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
