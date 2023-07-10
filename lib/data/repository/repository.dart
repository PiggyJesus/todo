import 'package:todo/data/local/unit/local_unit.dart';
import 'package:todo/data/remote/unit/remote_unit.dart';
import 'package:todo/domain/models/task_model.dart';
import 'package:todo/domain/repository/task_repository.dart';

class TaskRepositoryImpl implements TaskRepository {
  late final LocalUnit _localUnit;
  late final RemoteUnit _remoteUnit;

  TaskRepositoryImpl(
      {required LocalUnit localUnit, required RemoteUnit remoteUnit}) {
    _localUnit = localUnit;
    _remoteUnit = remoteUnit;
  }

  @override
  Future<bool> delete(String uuid) async {
    final localResult = await _localUnit.delete(uuid);

    if (localResult) {
      // в локальную бд записалось
      final remoteResult = await _remoteUnit.delete(uuid);
      if (remoteResult.status == 400) {
        // не соответвие ревизий или неправильный запрос - синхронизируем
        await _sync();
      }
      return true; // либо нет интернета, либо записалось на сервер
    }

    return false; // не получилось записать в локальную бд - ошибка
  }

  @override
  Future<TaskModel?> getTask(String uuid) async {
    final localResult = await _localUnit.getTask(uuid);

    if (localResult != null) {
      final remoteResult = await _remoteUnit.getTask(uuid);

      if (remoteResult.status == 400) {
        await _sync();
      }
    }

    return localResult;
  }

  @override
  Future<List<TaskModel>> getAll() async {
    await _sync(); // на всякий случай синхронизируем
    // данные берем из локального хранилища, на случай отсутсвия интернета
    return _localUnit.getAll();
  }

  @override
  Future<bool> insert(TaskModel task) async {
    final localResult = await _localUnit.insert(task);

    if (localResult) {
      // в локальную бд записалось
      final remoteResult = await _remoteUnit.insert(task);

      if (remoteResult.status == 400) {
        // не соответвие ревизий или неправильный запрос - синхронизируем
        await _sync();
      }
      return true; // либо нет интернета, либо записалось на сервер
    }

    return false;
  }

  @override
  Future<bool> update(TaskModel task) async {
    final localResult = await _localUnit.update(task);

    if (localResult) {
      // в локальную бд записалось
      final remoteResult = await _remoteUnit.update(task);
      if (remoteResult.status == 400) {
        // не соответвие ревизий или неправильный запрос - синхронизируем
        await _sync();
      }
      return true; // либо нет интернета, либо записалось на сервер
    }

    return false;
  }

  Future<bool> _sync() async {
    final localData = await _localUnit.getAll();
    final remoteData = await _remoteUnit.getAll();
    if (remoteData.status != 200) {
      return false;
    }

    // remoteData.status == 200 => получили дату и ревизию

    var result = true;

    var allTasks = <String, TaskModel>{};

    for (var task in localData) {
      allTasks[task.uuid] = task;
    }

    for (var remoteTask in remoteData.data as List<TaskModel>) {
      String uuid = remoteTask.uuid;
      if (allTasks.containsKey(uuid)) {
        final localTask = allTasks[uuid]!;
        if (localTask.changedAt.isBefore(remoteTask.changedAt)) {
          result = result && await _localUnit.insert(remoteTask);
          allTasks[uuid] = remoteTask;
        } else {
          if (localTask.deleted) {
            result = result && await _localUnit.delete(uuid);
            allTasks.remove(uuid);
          }
        }
      } else {
        result = result && await _localUnit.insert(remoteTask);
        allTasks[uuid] = remoteTask;
      }
    }

    result = result &&
        (await _remoteUnit.postAll(allTasks.values.toList())).status == 200;

    return result; // если одна из записей не сработала, возвращаем false
  }
}
