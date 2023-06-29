import 'package:todo/domain/models/importance.dart';

class TaskModel {
  final String uuid;
  Importance importance;
  DateTime? doUntil;
  String name;
  bool isDone;

  TaskModel({
    required this.uuid,
    required this.name,
    required this.importance,
    this.doUntil,
    this.isDone = false,
  });

  TaskModel copyWith({
    String? uuid,
    String? name,
    DateTime? doUntil,
    bool? isDone,
    Importance? importance,
  }) {
    return TaskModel(
      uuid: uuid ?? this.uuid,
      name: name ?? this.name,
      doUntil: doUntil ?? this.doUntil,
      isDone: isDone ?? this.isDone,
      importance: importance ?? this.importance,
    );
  }
}
