import 'package:todo/domain/models/task_model.dart';

abstract class LocalTaskRepository {
  Future<List<TaskModel>> getAll();

  Future<bool> insert(TaskModel task);

  Future<bool> update(TaskModel task);

  Future<bool> delete(String uuid);
}
