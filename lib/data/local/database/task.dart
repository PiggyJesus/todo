import 'package:isar/isar.dart';
import 'package:todo/domain/models/importance.dart';

part 'task.g.dart';

@collection
class Task {
  Id get id => uuid.hashCode;

  @enumerated
  late Importance importance;
  late String uuid;
  DateTime? doUntil;
  late String name;
  late bool isDone;
}
