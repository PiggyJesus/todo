import 'package:todo/domain/models/task_model.dart';

abstract class RemoteTaskRepository {
  Future<List<TaskModel>> getAll();
  
  Future<List<TaskModel>> updateAll(List<TaskModel> tasksList);

  Future<bool> insert(TaskModel task);

  Future<TaskModel?> get(String uuid);

  Future<bool> update(TaskModel task);

  Future<bool> delete(String uuid);
}
