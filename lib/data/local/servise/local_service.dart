import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo/data/local/database/localTask.dart';

class LocalService {
  Isar? _isar;

  LocalService() {
    _isarGetter;
  }

  Future<Isar> get _isarGetter async {
    final appDir = await getApplicationDocumentsDirectory();
    _isar ??= await Isar.open(
      [LocalTaskSchema],
      directory: appDir.path,
    );
    return _isar!;
  }

  Future<LocalTask?> getTask(String uuid) async {
    final isar = await _isarGetter;

    return isar.localTasks.filter().uuidEqualTo(uuid).findFirst();
  }

  Future<List<LocalTask>> getAll() async {
    final isar = await _isarGetter;
    return isar.localTasks.where().findAll();
  }

  Future<bool> insert(LocalTask task) async {
    final isar = await _isarGetter;

    final isEmpty =
        await isar.localTasks.filter().uuidEqualTo(task.uuid).isEmpty();
    if (!isEmpty) {
      return false;
    }

    isar.writeTxn(() async {
      return await isar.localTasks.put(task) > 0;
    });
    return true;
  }

  Future<bool> update(LocalTask task) async {
    final isar = await _isarGetter;
    isar.writeTxn(() async {
      return await isar.localTasks.put(task) > 0;
    });
    return true;
  }

  Future<bool> delete(String uuid) async {
    final isar = await _isarGetter;
    return isar.writeTxn(() async {
      return await isar.localTasks.filter().uuidEqualTo(uuid).deleteFirst();
    });
  }
}
