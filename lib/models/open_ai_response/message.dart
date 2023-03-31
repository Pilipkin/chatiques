import 'package:hive/hive.dart';

part 'message.g.dart';

@HiveType(typeId: 0)
class Message extends HiveObject {
  @HiveField(0)
  late String role;

  @HiveField(1)
  late String content;

  @HiveField(2)
  late DateTime timestamp;

  Message({required this.role, required this.content, required this.timestamp});
}
