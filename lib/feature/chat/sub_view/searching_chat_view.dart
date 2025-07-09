import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskproject/core/constant/app_style.dart';
import 'package:taskproject/core/mock/data.dart';
import 'package:taskproject/core/utils/mock_utils.dart';
import 'package:taskproject/core/utils/valid_utils.dart';
import 'package:taskproject/feature/chat/state/chat_state.dart';
import 'package:taskproject/feature/login/state/auth_state.dart';
import 'package:taskproject/model/message_model.dart';
import 'package:taskproject/model/user_model.dart';

class SearchingChatView extends StatefulWidget {
  const SearchingChatView({super.key, required this.user});

  final UserModel user;

  @override
  State<SearchingChatView> createState() => _SearchingChatViewState();
}

class _SearchingChatViewState extends State<SearchingChatView> {
  late final String chatRoomId;
  late final List<Message> messages;
  final TextEditingController _searchCtrl = TextEditingController();
  List<Message> filteredMessages = [];
  Timer? _debounce;

  @override
  void initState() {
    Future.microtask(() => init());
    super.initState();
  }

  Future<void> init() async {
    final chatRooms = context.read<ChatCubit>().state.chatRooms;
    chatRoomId = getChatRoomId1(myUid, widget.user.id, chatRooms);
    messages = getListMessage(chatRoomId);
    setState(() {
      filteredMessages = messages;
    });
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(seconds: 1), () {
      setState(() {
        filteredMessages = messages
            .where((msg) => msg.message.toLowerCase().contains(query.toLowerCase()))
            .toList();
      });
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _searchCtrl.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back_ios, color: Colors.blue),
        ),
        title: const Text(
          'Searching',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        titleSpacing: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            _buildChatsSearchWidget(),
            const SizedBox(height: AppSize.paddingMenu,),

            Expanded(
              child: ListView.builder(
                itemCount: filteredMessages.length,
                itemBuilder: (context, index) {
                  final message = filteredMessages[index];
                  return _messageTile(message);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }



  Widget _messageTile(Message message){
    final user = getUser(message.senderId);
    final myId = context.watch<AuthenticationCubit>().state.userModel!.id;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSize.paddingMenu),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage(user.pathImage),
          ),

          const SizedBox(width: AppSize.paddingMenu,),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(myId == user.id ? 'You' : user.userName),
                Text(
                  message.message,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  formatTime(message.timestamp),
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildChatsSearchWidget() => Container(
    decoration: BoxDecoration(
      color: Colors.black12,
      borderRadius: BorderRadius.circular(15),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(width: 15),
        const Icon(Icons.search),
        const SizedBox(width: 15),
        Expanded(
          child: TextField(
            controller: _searchCtrl,
            onChanged: _onSearchChanged,
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: 'Search',
            ),
          ),

        ),
      ],
    ),
  );
}
