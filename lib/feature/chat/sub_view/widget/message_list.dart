import 'package:flutter/material.dart';
import 'package:taskproject/core/mock/data.dart';
import 'package:taskproject/model/message_model.dart';
import 'message_received.dart';
import 'message_sent.dart';


class MessageList extends StatefulWidget {
  const MessageList({super.key,
  required this.messages,});

  final List<Message> messages;

  @override
  State<MessageList> createState() => _MessageListState();
}

class _MessageListState extends State<MessageList> {
  @override
  Widget build(BuildContext context) {

    return ListView.builder(
      reverse: true,
      itemCount: widget.messages.length,
      itemBuilder: (context, index) {
        final message = widget.messages.elementAt(index);
        final isMyMessage = message.senderId == myUid;

        if (isMyMessage) {
          return MessageSent(message: message);
        } else {
          return MessageReceived(message: message);
        }
      },
    );
  }
}
