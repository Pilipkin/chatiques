import 'package:auto_route/auto_route.dart';
import 'package:chatiques/common/services/locator.dart';
import 'package:chatiques/common/services/storage_service.dart';
import 'package:chatiques/features/ai_conversation/cubit/ai_conversation_cubit.dart';
import 'package:chatiques/features/ai_conversation/cubit/ai_processing_cubit.dart';
import 'package:chatiques/repositories/openai/openai_repositoty_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'ai_conversation_screen.dart';

@RoutePage()
class AiConversationWrapper extends StatelessWidget {
  const AiConversationWrapper(
      {Key? key, @PathParam('chatId') required this.chatId})
      : super(key: key);

  final String chatId;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AiConversationCubit(
            locator<OpenAIRepositoryImpl>(),
            locator<StorageService>(),
            chatId,
          ),
        ),
        BlocProvider(
          create: (_) => AiResponseProcessingCubit(),
        ),
      ],
      child: AiConversationScreen(
        chatId: chatId,
      ),
    );
  }
}
