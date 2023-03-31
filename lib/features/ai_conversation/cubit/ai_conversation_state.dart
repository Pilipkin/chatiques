import 'package:chatiques/models/open_ai_response/message.dart';
import 'package:equatable/equatable.dart';

abstract class AiConversationState extends Equatable {
  const AiConversationState();

  @override
  List<Object> get props => [];
}

class AiConversationInitial extends AiConversationState {
  const AiConversationInitial();
}

class AiConversationMessagesLoaded extends AiConversationState {
  final List<Message> messages;

  const AiConversationMessagesLoaded(this.messages);

  @override
  List<Object> get props => [messages];
}

class AiConversationError extends AiConversationState {
  final String error;

  const AiConversationError(this.error);

  @override
  List<Object> get props => [error];
}
