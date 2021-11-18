import 'package:hive_flutter/adapters.dart';
import 'package:uuid/uuid.dart';
part 'todo.g.dart';

@HiveType(typeId: 0)
class Todo extends HiveObject {
  @HiveField(0)
  String id;
  @HiveField(1)
  String description;
  @HiveField(2)
  bool isCompleted;
  Todo({required this.description})
      : this.id = Uuid().v1(),
        this.isCompleted = false;
}
