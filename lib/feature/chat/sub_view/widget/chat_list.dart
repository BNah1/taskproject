// import 'package:taskproject/core/widget/error_widget.dart';
// import 'package:taskproject/core/widget/loader_widget.dart';
//
// import 'chat_tile.dart';
//
// class ChatsList extends ConsumerWidget {
//   const ChatsList({super.key});
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final chatsList = ref.watch(getAllChatsProvider);
//     final myUid = FirebaseAuth.instance.currentUser!.uid;
//     return chatsList.when(
//       data: (chats) {
//         return ListView.builder(
//           itemCount: chats.length,
//           itemBuilder: (context, index) {
//             final chat = chats.elementAt(index);
//             final userId = chat.members.where((e) => e != myUid).firstOrNull;
//             if(chats.isEmpty || userId == null){
//               return const SizedBox();
//             }
//             return ChatTile(
//               user: userId,
//               lastMessage: chat.lastMessage,
//               lastMessageTs: chat.lastMessageTs,
//               chatroomId: chat.chatroomId,
//             );
//           },
//         );
//       },
//       error: (error, stackTrace) {
//         return const ErrorWidget();
//       },
//       loading: () {
//         return const Loader();
//       },
//     );
//   }
// }