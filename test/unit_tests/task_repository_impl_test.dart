import 'package:flutter_test/flutter_test.dart';
import 'package:todo/data/local/unit/local_unit.dart';
import 'package:todo/data/repository/repository.dart';
import 'package:todo/domain/models/task_model.dart';

import '../data/local_servise_mock.dart';
import '../data/remote_unit_mock.dart';
import '../data/test_tasks.dart';

void main() {
  group('task repository impl tests', () {
    test('get all empty', () async {
      final taskRepositoryImpl = TaskRepositoryImpl(
          localUnit: LocalUnit(LocalServiseMock()),
          remoteUnit: RemoteUnitMock());
      final all1 = await taskRepositoryImpl.getAll();
      expect(all1, <TaskModel>[]);
    });

    test('put one get one', () async {
      final taskRepositoryImpl = TaskRepositoryImpl(
          localUnit: LocalUnit(LocalServiseMock()),
          remoteUnit: RemoteUnitMock());
      await taskRepositoryImpl.insert(taskModels[0]);
      final task = await taskRepositoryImpl.getTask(taskModels[0].uuid);
      expect(task, taskModels[0]);
    });

    test('update', () async {
      final taskRepositoryImpl = TaskRepositoryImpl(
          localUnit: LocalUnit(LocalServiseMock()),
          remoteUnit: RemoteUnitMock());
      await taskRepositoryImpl.insert(taskModels[0]);
      final newTask = taskModels[0].copyWith(name: "1234");
      await taskRepositoryImpl.update(newTask);
      final task = await taskRepositoryImpl.getAll();
      expect(task[0].name, newTask.name);
    });

    test('delete', () async {
      final taskRepositoryImpl = TaskRepositoryImpl(
          localUnit: LocalUnit(LocalServiseMock()),
          remoteUnit: RemoteUnitMock());
      await taskRepositoryImpl.insert(taskModels[0]);
      await taskRepositoryImpl.delete(taskModels[0].uuid);
      final task = await taskRepositoryImpl.getAll();
      expect(task, []);
    });
  });
}
