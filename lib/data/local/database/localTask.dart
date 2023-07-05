import 'package:isar/isar.dart';
import 'package:todo/domain/models/importance.dart';

part 'localTask.g.dart';

@collection
class LocalTask {
  Id get id => uuid.hashCode;

  @enumerated
  late Importance importance;
  late String uuid;
  DateTime? deadline;
  late String name;
  late bool done;
  late DateTime createdAt;
  late DateTime changedAt;
  late String lastUpdatedBy;
  String? color;
}
