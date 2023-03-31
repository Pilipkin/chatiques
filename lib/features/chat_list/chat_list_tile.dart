import 'package:chatiques/features/chat_list/chat_title_edit_bottomsheet.dart';
import 'package:flutter/material.dart';

class ChatListTile extends StatelessWidget {
  final String chatId;
  final String chatTitle;
  final VoidCallback onTap;
  final ValueChanged<String> onTitleChanged;

  const ChatListTile({
    Key? key,
    required this.chatId,
    required this.chatTitle,
    required this.onTap,
    required this.onTitleChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: GestureDetector(
        child: Text(chatTitle),
      ),
      trailing: GestureDetector(
        onTap: () async {
          final newTitle = await showModalBottomSheet<String>(
            context: context,
            isScrollControlled: true,
            builder: (context) =>
                ChatTitleEditBottomSheet(initialTitle: chatTitle),
          );

          if (newTitle != null && newTitle != chatTitle) {
            onTitleChanged(newTitle);
          }
        },
        child: const Icon(Icons.edit),
      ),
    );
  }
}
