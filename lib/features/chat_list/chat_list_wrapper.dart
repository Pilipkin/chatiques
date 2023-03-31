import 'package:auto_route/auto_route.dart';
import 'package:chatiques/common/services/locator.dart';
import 'package:chatiques/common/services/storage_service.dart';
import 'package:chatiques/features/chat_list/chat_list_cubit.dart';
import 'package:chatiques/features/chat_list/chat_list_screen.dart';
import 'package:chatiques/models/open_ai_response/chat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class ChatListWrapper extends StatelessWidget {
  const ChatListWrapper({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ChatListCubit(
        locator<StorageService>(),
      ),
      child: const ChatListScreen(),
    );
  }
}

Future<void> showEditChatTitleBottomSheet(
    BuildContext context, Chat chat) async {
  await showModalBottomSheet<String>(
    context: context,
    isScrollControlled: true,
    builder: (BuildContext bottomSheetContext) {
      final TextEditingController controller =
          TextEditingController(text: chat.name);
      return Padding(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          top: 20,
        ).copyWith(bottom: MediaQuery.of(context).padding.bottom),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Редактировать название чата',
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: controller,
                autofocus: true,
                decoration: const InputDecoration(
                  hintText: 'Введите новое название чата',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      final newTitle = controller.text.trim();
                      if (newTitle.isNotEmpty && newTitle != chat.name) {
                        context
                            .read<ChatListCubit>()
                            .updateChatTitle(chat.id, newTitle);
                      }
                      Navigator.pop(bottomSheetContext, newTitle);
                    },
                    child: const Text('Сохранить'),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
