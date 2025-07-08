import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskproject/core/utils/snapshot_utils.dart';
import 'package:taskproject/feature/chat/state/chat_controller_model.dart';
import 'package:taskproject/feature/chat/state/chat_state.dart';
import 'package:taskproject/feature/login/state/auth_state.dart';

import 'chat_tile.dart';

class ChatList extends StatelessWidget {
  const ChatList({super.key});


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatCubit, ChatControllerModel>(
      builder: (context, state) {
        return buildStateView(status: state.status, onSuccess: (){
          final myUid = context.watch<AuthenticationCubit>().state.userModel!.id;
          final list = state.chatRooms;
          return ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, index) {
              final chat = list.elementAt(index);
              final userId = chat.members.where((e) => e != myUid).firstOrNull;
              if(list.isEmpty || userId == null){
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
