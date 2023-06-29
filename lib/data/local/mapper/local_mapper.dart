import 'package:todo/data/local/database/task.dart';
import 'package:todo/domain/models/task_model.dart';

class LocalMapper {
  static TaskModel toModel(Task task) {
    return TaskModel(
      uuid: task.uuid,
      name: task.name,
      importance: task.importance,
      doUntil: task.doUntil,
      isDone: task.isDone,
    );
  }

  static Task fromModel(TaskModel taskModel) {
    return Task()
    ..uuid = taskModel.uuid
    ..name = taskModel.name
    ..importance = taskModel.importance
    ..isDone = taskModel.isDone
    ..doUntil = taskModel.doUntil;
  }
}
