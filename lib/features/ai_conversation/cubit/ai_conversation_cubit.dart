import 'package:chatiques/common/services/storage_service.dart';
import 'package:chatiques/features/ai_conversation/cubit/ai_conversation_state.dart';
import 'package:chatiques/features/ai_conversation/cubit/ai_processing_cubit.dart';
import 'package:chatiques/models/open_ai_response/message.dart';
import 'package:chatiques/repositories/openai/openai_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AiConversationCubit extends Cubit<AiConversationState> {
  final CancelToken _cancelToken = CancelToken();
  final OpenAIRepository _openAIRepository;
  final StorageService _storageService;
  final String _chatId;

  AiConversationCubit(
    this._openAIRepository,
    this._storageService,
    this._chatId,
  ) : super(const AiConversationInitial()) {
    _loadMessages();
  }

  Future<void> _loadMessages() async {
    final messages = await _storageService.getMessages(_chatId);
    emit(AiConversationMessagesLoaded(messages));
  }

  Future<void> _saveMessage(Message message) async {
    await _storageService.saveMessage(_chatId, message);
    _loadMessages();
  }

  Future<void> sendMessage(
    String question,
    AiResponseProcessingCubit aiResponseProcessingCubit,
  ) async {
    if (state is AiConversationMessagesLoaded) {
      final userMessage = Message(
        role: 'user',
        content: question,
        timestamp: DateTime.now(),
      );
      await _saveMessage(userMessage);

      try {
        final responseStream = await _openAIRepository.getCompletion(
          question,
          (state as AiConversationMessagesLoaded).messages,
          _cancelToken,
        );

        aiResponseProcessingCubit.reset();

        responseStream?.listen(
          (response) {
            final text = response.choices.last.delta.content;
            aiResponseProcessingCubit.addWord(text ?? '');
          },
          onDone: () async {
            final aiMessage = Message(
              content: aiResponseProcessingCubit.state.trim(),
              role: 'assistant',
              timestamp: DateTime.now(),
            );

            aiResponseProcessingCubit.reset();

            if (aiMessage.content.isNotEmpty) {
              await _saveMessage(aiMessage);
            }
          },
        );
      } catch (e) {
        emit(AiConversationError(e.toString()));
      }
    }
  }

  @override
  Future<void> close() {
    _cancelToken.cancel();
    return super.close();
  }
}
