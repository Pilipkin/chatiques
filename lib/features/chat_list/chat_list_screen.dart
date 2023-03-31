import 'package:auto_route/auto_route.dart';
import 'package:chatiques/common/widgets/confirm_delete_bottomsheet.dart';
import 'package:chatiques/features/chat_list/chat_create_bottmsheet.dart';
import 'package:chatiques/features/chat_list/chat_list_cubit.dart';
import 'package:chatiques/features/chat_list/chat_list_tile.dart';
import 'package:chatiques/models/open_ai_response/chat.dart';
import 'package:chatiques/navigation/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class ChatListScreen extends StatelessWidget {
  const ChatListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Чаты'),
      ),
      body: BlocBuilder<ChatListCubit, List<Chat>>(
        builder: (context, state) {
          return Column(
            children: [
              TextButton(
                onPressed: () => showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (_) => ChatCreateBottomSheet(
                    onAddPress: (chatName) =>
                        context.read<ChatListCubit>().addChat(chatName),
                  ),
                ),
                child: const Text('Добавить'),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: state.length,
                  itemBuilder: (context, index) {
                    final chat = state[index];
                    return Dismissible(
                        key: Key(chat.id),
                        confirmDismiss: (direction) async {
                          bool? shouldDelete = await showModalBottomSheet<bool>(
                            context: context,
                            isScrollControlled: true,
                            builder: (_) => ConfirmDeleteBottomSheet(
                              onConfirm: () => Navigator.pop(context, true),
                              onCancel: () => Navigator.pop(context, false),
                            ),
                          );

                          return shouldDelete ?? false;
                        },
                        onDismissed: (direction) {
                          context.read<ChatListCubit>().deleteChat(chat.id);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Чат "${chat.name}" удален'),
                              backgroundColor: Colors.green,
                            ),
                          );
                        },
                        background: Container(
                          color: Colors.red,
                          alignment: Alignment.centerLeft,
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.0),
                            child: Icon(Icons.delete, color: Colors.white),
                          ),
                        ),
                        child: ChatListTile(
                          chatId: chat.id,
                          chatTitle: chat.name,
                          onTap: () {
                            context.router
                                .push(AiConversationWrapper(chatId: chat.id));
                          },
                          onTitleChanged: (newTitle) {
                            context
                                .read<ChatListCubit>()
                                .updateChatTitle(chat.id, newTitle);
                          },
                        ));
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

// void showCreateBottomSheet(BuildContext context) {
//   showModalBottomSheet<void>(
//     context: context,
//     isScrollControlled: true,
//     builder: (BuildContext bottomSheetContext) {
//       final TextEditingController controller = TextEditingController();
//       return Padding(
//         padding: EdgeInsets.only(
//           left: 20,
//           right: 20,
//           top: 20,
//           bottom: MediaQuery.of(context).padding.bottom,
//         ),
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               const Text(
//                 'Добавить новый чат',
//                 style: TextStyle(fontSize: 20),
//               ),
//               const SizedBox(height: 16),
//               TextField(
//                 controller: controller,
//                 autofocus: true,
//                 decoration: const InputDecoration(
//                   hintText: 'Введите название чата',
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//               const SizedBox(height: 16),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   ElevatedButton(
//                     onPressed: () {
//                       context.read<ChatListCubit>().addChat(controller.text);
//                       Navigator.pop(bottomSheetContext);
//                     },
//                     child: const Text('Добавить'),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       );
//     },
//   );
// }
