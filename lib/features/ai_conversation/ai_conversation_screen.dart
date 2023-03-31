import 'package:chatiques/features/ai_conversation/cubit/ai_conversation_cubit.dart';
import 'package:chatiques/features/ai_conversation/cubit/ai_conversation_state.dart';
import 'package:chatiques/features/ai_conversation/cubit/ai_processing_cubit.dart';
import 'package:chatiques/models/open_ai_response/message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';

class AiConversationScreen extends StatefulWidget {
  const AiConversationScreen({Key? key, required this.chatId})
      : super(key: key);
  final String chatId;

  @override
  State<AiConversationScreen> createState() => _AiConversationScreenState();
}

class _AiConversationScreenState extends State<AiConversationScreen> {
  final TextEditingController _textEditingController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _textEditingController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _sendMessage(String text) async {
    if (text.isNotEmpty) {
      final aiResponseProcessingCubit =
          context.read<AiResponseProcessingCubit>();
      final aiConversationCubit = context.read<AiConversationCubit>();

      aiResponseProcessingCubit.reset();
      aiConversationCubit.sendMessage(text, aiResponseProcessingCubit);
      _textEditingController.clear();
    }
  }

  void _scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  Widget _buildMessageList(List<Message> messages) {
    return ListView.builder(
      controller: _scrollController,
      itemCount: messages.length + 1,
      itemBuilder: (context, index) {
        if (index < messages.length) {
          final message = messages[index];
          return ListTile(
            title: Text(message.content),
            subtitle: Text(message.role),
            trailing: message.role == 'assistant'
                ? IconButton(
                    icon: const Icon(Icons.share),
                    onPressed: () {
                      final userQuestion = messages[index - 1].content;
                      _shareAiResponse(userQuestion, message.content);
                    },
                  )
                : null,
          );
        } else {
          return BlocBuilder<AiResponseProcessingCubit, String>(
            builder: (context, state) {
              return ListTile(
                title: Text(state),
                subtitle: Text(state.isNotEmpty ? 'assistant' : ''),
              );
            },
          );
        }
      },
    );
  }

  Widget _buildInputField() {
    return Padding(
      padding: const EdgeInsets.all(12.0).copyWith(top: 0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _textEditingController,
              decoration: const InputDecoration(
                hintText: 'Введите сообщение',
              ),
              onSubmitted: _sendMessage,
            ),
          ),
          IconButton(
            onPressed: () => _sendMessage(_textEditingController.value.text),
            icon: const Icon(Icons.send),
          ),
        ],
      ),
    );
  }

  void _shareAiResponse(String userQuestion, String aiResponse) {
    Share.share(
        'Посмотри, что ИИ ответил на мой вопрос:\n$userQuestion\nОтвет:\n$aiResponse');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('AI Conversation')),
        body: SafeArea(
          child: Column(
            children: [
              BlocBuilder<AiConversationCubit, AiConversationState>(
                builder: (context, state) {
                  if (state is AiConversationMessagesLoaded) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      _scrollToBottom();
                    });
                    return Expanded(child: _buildMessageList(state.messages));
                  } else {
                    return const Expanded(
                      child: SizedBox.shrink(),
                    );
                  }
                },
              ),
              _buildInputField(),
            ],
          ),
        ));
  }
}
