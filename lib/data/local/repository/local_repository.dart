import 'package:todo/data/local/mapper/local_mapper.dart';
import 'package:todo/data/local/servise/local_servise.dart';
import 'package:todo/domain/models/task_model.dart';
import 'package:todo/domain/repository/task_repository.dart';

class LocalRepository implements TaskRepository {
  final LocalServise _servise = LocalServise();

  @override
  Future<bool> delete(String uuid) {
    return _servise.delete(uuid);
  }

  @override
  Future<List<TaskModel>> getAll() async {
    final data = await _servise.getAll();
    return data.map((task) => LocalMapper.toModel(task)).toList();
  }

  @override
  Future<bool> insert(TaskModel task) {
    return _servise.insert(LocalMapper.fromModel(task));
  }

  @override
  Future<bool> update(TaskModel task) {
    return _servise.update(LocalMapper.fromModel(task));
  }
}
