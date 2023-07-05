import 'package:todo/data/local/database/localTask.dart';
import 'package:todo/domain/models/task_model.dart';

class LocalMapper {
  static TaskModel toModel(LocalTask task) {
    return TaskModel(
      uuid: task.uuid,
      name: task.name,
      importance: task.importance,
      deadline: task.deadline,
      done: task.done,
      changedAt: task.changedAt,
      createdAt: task.createdAt,
      lastUpdatedBy: task.lastUpdatedBy,
      color: task.color,
    );
  }

  static LocalTask fromModel(TaskModel taskModel) {
    return LocalTask()
      ..uuid = taskModel.uuid
      ..name = taskModel.name
      ..importance = taskModel.importance
      ..deadline = taskModel.deadline
      ..done = taskModel.done
      ..changedAt = taskModel.changedAt
      ..createdAt = taskModel.createdAt
      ..lastUpdatedBy = taskModel.lastUpdatedBy
      ..color = taskModel.color;
  }
}
