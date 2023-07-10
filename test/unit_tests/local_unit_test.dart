import 'package:flutter_test/flutter_test.dart';
import 'package:todo/data/local/unit/local_unit.dart';
import 'package:todo/domain/models/task_model.dart';

import '../data/local_servise_mock.dart';
import '../data/test_tasks.dart';

void main() {
  group('local unit tests', () {
    test('get all empty', () async {
      final localUnit = LocalUnit(LocalServiseMock());
      final all1 = await localUnit.getAll();
      expect(all1, <TaskModel>[]);
    });

    test('put one get one', () async {
      final localUnit = LocalUnit(LocalServiseMock());
      await localUnit.insert(taskModels[0]);
      final task = await localUnit.getTask(taskModels[0].uuid);
      expect(task, taskModels[0]);
    });

    test('update', () async {
      final localUnit = LocalUnit(LocalServiseMock());
      await localUnit.insert(taskModels[0]);
      final newTask = taskModels[0].copyWith(name: "1234");
      await localUnit.update(newTask);
      final task = await localUnit.getAll();
      expect(task[0].name, newTask.name);
    });

    test('delete', () async {
      final localUnit = LocalUnit(LocalServiseMock());
      await localUnit.insert(taskModels[0]);
      await localUnit.delete(taskModels[0].uuid);
      final task = await localUnit.getAll();
      expect(task, []);
    });
  });
}
