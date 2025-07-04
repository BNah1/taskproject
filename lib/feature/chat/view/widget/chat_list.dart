import 'package:flutter/material.dart';
import 'package:taskproject/core/mock/data.dart';
import 'package:taskproject/core/utils/mock_utils.dart';
import 'package:taskproject/core/utils/snapshot_utils.dart';

import 'chat_tile.dart';

class ChatList extends StatelessWidget {
  const ChatList({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getChatRoom(),
      builder: (context, snapshot) {
        return checkSnapShot(snapshot, (chats){
          return ListView.builder(
            itemCount: chats.length,
            itemBuilder: (context, index) {
              final chat = chats.elementAt(index);
              final userId = chat.members.where((e) => e != myUid).firstOrNull;
              if(chats.isEmpty || userId == null){
                return const SizedBox.shrink();
              }
              return ChatTile(
                userId: userId,
                lastMessage: chat.lastMessage,
                lastMessageTs: chat.lastMessageTs,
                chatroomId: chat.chatroomId,
              );
            },
          );
        });
      }
    );
  }
}
