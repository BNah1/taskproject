import 'package:flutter/material.dart';
import 'package:taskproject/core/mock/data.dart';
import 'package:taskproject/feature/chat/state/chat_state.dart';
import 'package:taskproject/feature/chat/view/widget/chat_list.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatsView extends StatefulWidget {
  const ChatsView({super.key});

  @override
  State<ChatsView> createState() => _ChatsViewState();
}

class _ChatsViewState extends State<ChatsView> {
  @override
  void initState() {
    Future.microtask(() => init());
    super.initState();
  }

  Future<void> init() async {
    await context.read<ChatCubit>().init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 10,
            bottom: 10,
            left: 20,
            right: 20,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // build chats app bar
                _buildChatsAppBar(),

                const SizedBox(height: 10),

                // Search widget
                _buildChatsSearchWidget(),

                _listUser(),

                const SizedBox(height: 15),

                // Chats List
                const SizedBox(height: 600, child: ChatList()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildChatsAppBar() => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(100)),
         child: const Icon(Icons.menu,size: 35,),
          ),
          // CircleAvatar(
          //   radius: 28,
          //   backgroundImage: AssetImage(MockData.listUserMock[0].pathImage),
          // ),
          const SizedBox(width: 15),
          const Text(
            'Messages',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.black12,
            borderRadius: BorderRadius.circular(100)),
        child: const Icon(Icons.edit,size: 35,),
      ),
    ],
  );

  Widget _listUser() {
    return Container(
      height: 100,
      padding: const EdgeInsets.only(top: 10),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: MockData.listUserMock.length,
        itemBuilder: (context, index) {
          final user = MockData.listUserMock[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 32,
                  backgroundImage: AssetImage(user.pathImage),
                ),
                Text(user.userName),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildChatsSearchWidget() => Container(
    decoration: BoxDecoration(
      color: Colors.black12,
      borderRadius: BorderRadius.circular(15),
    ),
    child: const Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(width: 15),
        Icon(Icons.search),
        SizedBox(width: 15),
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Search',
              hintStyle: TextStyle(),
            ),
          ),
        ),
      ],
    ),
  );
}
