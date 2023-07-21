import 'package:mockito/mockito.dart';
import 'package:todo/data/local/database/local_task.dart';
import 'package:todo/data/local/servise/local_service.dart';

class LocalServiseMock extends Mock implements LocalService {
  List<LocalTask> data = [];

  @override
  Future<LocalTask?> getTask(String uuid) async {
    try {
      return data.firstWhere((element) => element.uuid == uuid);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<List<LocalTask>> getAll() async {
    return data;
  }

  @override
  Future<bool> insert(LocalTask task) async {
    final isEmpty = (await getTask(task.uuid)) == null;
    if (!isEmpty) {
      return false;
    }
    data.add(task);
    return true;
  }

  @override
  Future<bool> delete(String uuid) async {
    final isEmpty = (await getTask(uuid)) == null;
    if (isEmpty) {
      return false;
    }
    data.removeWhere((element) => element.uuid == uuid);
    return true;
  }

  @override
  Future<bool> update(LocalTask task) async {
    await delete(task.uuid);
    return insert(task);
  }
}
