import 'package:todo/domain/models/task_model.dart';

abstract class TaskRepository {
  Future<TaskModel?> getTask(String uuid);

  Future<List<TaskModel>> getAll();

  Future<bool> insert(TaskModel task);

  Future<bool> update(TaskModel task);

  Future<bool> delete(String uuid);
}
