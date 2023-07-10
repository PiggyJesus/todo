import 'package:todo/data/local/mapper/local_mapper.dart';
import 'package:todo/data/local/servise/local_service.dart';
import 'package:todo/domain/models/task_model.dart';

class LocalUnit {
  late final LocalService _localServise;

  LocalUnit(LocalService localService) {
    _localServise = localService;
  }

  Future<List<TaskModel>> getAll() async {
    final data = await _localServise.getAll();
    return data.map((e) => LocalMapper.toModel(e)).toList();
  }

  Future<TaskModel?> getTask(String uuid) async {
    final task = await _localServise.getTask(uuid);
    if (task == null) {
      return null;
    } else {
      return LocalMapper.toModel(task);
    }
  }

  Future<bool> insert(TaskModel task) {
    return _localServise.insert(LocalMapper.fromModel(task));
  }

  Future<bool> update(TaskModel task) {
    return _localServise.update(LocalMapper.fromModel(task));
  }

  Future<bool> delete(String uuid) {
    return _localServise.delete(uuid);
  }

  Future<bool> setAll(List<TaskModel> taks) {
    throw Exception("setAll is not emplemented");
  }
}
