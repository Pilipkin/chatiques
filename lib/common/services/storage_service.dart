import 'package:chatiques/models/open_ai_response/chat.dart';
import 'package:chatiques/models/open_ai_response/message.dart';
import 'package:hive_flutter/hive_flutter.dart';

class StorageService {
  Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(MessageAdapter());
    Hive.registerAdapter(ChatAdapter());
  }

  Future<void> createChat(Chat chat) async {
    final box = await Hive.openBox<Chat>('chats');
    await box.add(chat);
    await box.close();
  }

  Future<List<Chat>> getChats() async {
    final box = await Hive.openBox<Chat>('chats');
    final chats = box.values.toList();
    await box.close();
    return chats;
  }

  Future<void> saveMessage(String chatId, Message message) async {
    final box = await Hive.openBox<Message>('messages_$chatId');
    await box.add(message);
    await box.close();
  }

  Future<List<Message>> getMessages(String chatId) async {
    final box = await Hive.openBox<Message>('messages_$chatId');
    final messages = box.values.toList();
    await box.close();
    return messages;
  }

  Future<void> deleteAllMessages(String chatId) async {
    final box = await Hive.openBox<Message>('messages_$chatId');
    await box.clear();
    await box.close();
  }

  Future<void> deleteChat(String chatId) async {
    final chatBox = await Hive.openBox<Chat>('chats');

    final chatKey = chatBox.keys.firstWhere(
        (key) => chatBox.get(key)?.id == chatId,
        orElse: () => null);

    if (chatKey != null) {
      chatBox.delete(chatKey);
    }

    await chatBox.close();

    final messageBox = await Hive.openBox<Message>('messages_$chatId');
    await messageBox.clear();
    await messageBox.close();
  }

  Future<void> updateChatTitle(String chatId, String newTitle) async {
    final box = await Hive.openBox<Chat>('chats');

    final chatKey = box.keys.firstWhere(
      (key) => box.get(key)?.id == chatId,
      orElse: () => null,
    );

    if (chatKey != null) {
      final chat = box.get(chatKey);
      if (chat != null) {
        chat.name = newTitle;
        await box.put(chatKey, chat);
      }
    }
    await box.close();
  }
}
