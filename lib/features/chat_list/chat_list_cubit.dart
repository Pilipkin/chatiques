import 'package:chatiques/common/services/storage_service.dart';
import 'package:chatiques/models/open_ai_response/chat.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatListCubit extends Cubit<List<Chat>> {
  final StorageService _storageService;

  ChatListCubit(this._storageService) : super([]) {
    _loadChats();
  }

  Future<void> _loadChats() async {
    final chats = await _storageService.getChats();
    emit(chats);
  }

  Future<void> addChat(String name) async {
    if (name.isNotEmpty) {
      final chatId = DateTime.now().millisecondsSinceEpoch.toString();
      final chat = Chat(id: chatId, name: name);
      await _storageService.createChat(chat);
      _loadChats();
    }
  }

  Future<void> deleteChat(String id) async {
    await _storageService.deleteChat(id);
    _loadChats();
  }

  Future<void> updateChatTitle(String chatId, String newTitle) async {
    await _storageService.updateChatTitle(chatId, newTitle);
    _loadChats();
  }
}
