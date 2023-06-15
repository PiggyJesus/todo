import 'package:todo/presentation/utils/importance.dart';

class TaskModel {
  Importance importance;
  DateTime? doUntil;
  String name;
  bool isDone;

  TaskModel({
    required this.name,
    required this.importance,
    this.doUntil,
    this.isDone = false,
  });

  TaskModel copyWith({
    String? name,
    DateTime? doUntil,
    bool? isDone,
    Importance? importance,
  }) {
    return TaskModel(
      name: name ?? this.name,
      doUntil: doUntil ?? this.doUntil,
      isDone: isDone ?? this.isDone,
      importance: importance ?? this.importance,
    );
  }
}
