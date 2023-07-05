import 'package:todo/domain/models/task_model.dart';
import 'package:todo/domain/repository/remote/remote_task_repository.dart';

class RemoteRepository implements RemoteTaskRepository {
  @override
  Future<bool> delete(String uuid) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<TaskModel?> get(String uuid) {
    // TODO: implement get
    throw UnimplementedError();
  }

  @override
  Future<List<TaskModel>> getAll() {
    // TODO: implement getAll
    throw UnimplementedError();
  }

  @override
  Future<bool> insert(TaskModel task) {
    // TODO: implement insert
    throw UnimplementedError();
  }

  @override
  Future<bool> update(TaskModel task) {
    // TODO: implement update
    throw UnimplementedError();
  }

  @override
  Future<List<TaskModel>> updateAll(List<TaskModel> tasksList) {
    // TODO: implement updateAll
    throw UnimplementedError();
  }
}
