import 'package:flutter/material.dart';
import 'package:taskproject/core/constant/app_style.dart';
import 'package:taskproject/core/constant/routes.dart';
import 'package:taskproject/core/mock/data.dart';
import 'package:taskproject/core/utils/mock_utils.dart';
import 'package:taskproject/core/utils/snapshot_utils.dart';
import 'package:taskproject/feature/chat/state/chat_controller_model.dart';
import 'package:taskproject/feature/chat/state/chat_state.dart';
import 'package:taskproject/feature/chat/sub_view/widget/chat_user_info.dart';
import 'package:taskproject/feature/chat/sub_view/widget/message_list.dart';
import 'package:taskproject/feature/login/state/auth_state.dart';
import 'package:taskproject/model/message_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatBoxView extends StatefulWidget {
  const ChatBoxView({super.key, required this.userId});

  final String userId;

  @override
  State<ChatBoxView> createState() => _ChatBoxViewState();
}

class _ChatBoxViewState extends State<ChatBoxView> {
  late final TextEditingController messageController;
  late String chatRoomId;

  @override
  void initState() {
    super.initState();
    messageController = TextEditingController();
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatCubit, ChatControllerModel>(
      builder: (context, state) {
        final userId = context.watch<AuthenticationCubit>().state.userModel!.id;
        chatRoomId = getChatRoomId1(userId, widget.userId, state.chatRooms);
        List<Message> messages = getListMessage(chatRoomId);
        return buildStateView(
          status: state.status,
          onSuccess: () {
            return Scaffold(
              appBar: AppBar(
                actions: [_actionButtonAppBar()],
                leading: IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.arrow_back_ios, color: Colors.blue),
                ),
                titleSpacing: 0,
                title: ChatUserInfo(userId: widget.userId),
              ),
              body: Column(
                children: [
                  Expanded(child: MessageList(messages: messages)),
                  const Divider(),
                  _buildMessageInput((message) {
                    context.read<ChatCubit>().addChat(
                      Message(
                        message: message,
                        messageId: '121212',
                        senderId: myUid,
                        receiverId: widget.userId,
                        timestamp: DateTime.now(),
                        seen: false,
                      ),
                      chatRoomId,
                    );
                  }),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _actionButtonAppBar() {
    return Row(
      children: [
        const Icon(Icons.call, color: Colors.blue),
        const SizedBox(width: AppSize.paddingDashBoard),
        const Icon(Icons.video_camera_back_rounded, color: Colors.blue),
        const SizedBox(width: AppSize.paddingDashBoard),
        InkWell(
          onTap: () {
            Navigator.of(
              context,
              rootNavigator: true,
            ).pushNamed(AppRoutes.userInfoChat, arguments: widget.userId);
            print('object');
          },
          child: const Icon(Icons.info_rounded, color: Colors.blue),
        ),
        const SizedBox(width: AppSize.paddingMenu),
      ],
    );
  }

  Widget _buildMessageInput(void Function(String) tap) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.image, color: Colors.grey),
            onPressed: () async {
              // TODO: handle image selection
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.video_collection,
              color: Colors.grey,
              size: 20,
            ),
            onPressed: () async {
              // TODO: handle video selection
            },
          ),
          Expanded(
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(15),
              ),
              child: TextField(
                controller: messageController,
                decoration: const InputDecoration(
                  hintText: 'Aa',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(left: 20, bottom: 10),
                ),
                textInputAction: TextInputAction.done,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send, color: Colors.blue),
            onPressed: () async {
              tap(messageController.text);
              messageController.clear();
            },
          ),
        ],
      ),
    );
  }
}
