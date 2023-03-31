import 'package:hive/hive.dart';

part 'chat.g.dart';

@HiveType(typeId: 1)
class Chat extends HiveObject {
  @HiveField(0)
  late String id;

  @HiveField(1)
  late String name;

  Chat({required this.id, required this.name});
}
