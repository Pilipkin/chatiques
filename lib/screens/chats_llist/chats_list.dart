import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class ChatsList extends StatelessWidget {
  const ChatsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () => context.router.pushNamed('/chat/TEST_CHAT_ID_1'),
            child: const Text('CHATS_LIST'),
          ),
        ],
      ),
    );
  }
}
