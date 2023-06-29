import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo/data/local/database/task.dart';

class LocalServise {
  Isar? _isar;

  LocalServise() {
    _isarGetter;
  }

  Future<Isar> get _isarGetter async {
    final appDir = await getApplicationDocumentsDirectory();
    _isar ??= await Isar.open(
      [TaskSchema],
      directory: appDir.path,
    );
    return _isar!;
  }

  Future<List<Task>> getAll() async {
    final isar = await _isarGetter;
    return isar.tasks.where().findAll();
  }

  Future<bool> insert(Task task) async {
    final isar = await _isarGetter;

    final isEmpty = await isar.tasks.filter().uuidEqualTo(task.uuid).isEmpty();
    if (!isEmpty) {
      return false;
    }

    isar.writeTxn(() async {
      return await isar.tasks.put(task) > 0;
    });
    return true;
  }

  Future<bool> update(Task task) async {
    final isar = await _isarGetter;
    isar.writeTxn(() async {
      return await isar.tasks.put(task) > 0;
    });
    return true;
  }

  Future<bool> delete(String uuid) async {
    final isar = await _isarGetter;
    return isar.writeTxn(() async {
      return await isar.tasks
          .filter()
          .uuidEqualTo(uuid)
          .deleteFirst();
    });
  }
}
