import 'package:flutter_test/flutter_test.dart';
import 'package:todo/domain/models/importance.dart';
import 'package:todo/domain/models/task_model.dart';

import '../data/test_tasks.dart';

void main() {
  group('task model tests', () {
    test('create test', () {
      final task = TaskModel(
        uuid: 'ca6bff00-1b46-11ee-89fe-53adf2c1d030',
        name: 'ннн',
        importance: Importance.common,
        createdAt: DateTime(2023, 07, 05, 18, 15, 35, 280),
        changedAt: DateTime(2023, 07, 05, 18, 15, 38, 470),
        lastUpdatedBy: '123',
        done: true,
      );

      expect(task.uuid, 'ca6bff00-1b46-11ee-89fe-53adf2c1d030');
      expect(task.name, 'ннн');
      expect(task.importance, Importance.common);
      expect(task.createdAt, DateTime(2023, 07, 05, 18, 15, 35, 280));
      expect(task.changedAt, DateTime(2023, 07, 05, 18, 15, 38, 470));
      expect(task.lastUpdatedBy, '123');
      expect(task.done, true);
      expect(task.color, null);
      expect(task.deadline, null);
      expect(task.deleted, false);
    });

    test('to json #0', () {
      final json = taskModels[0].toJson();

      expect(json, jsonTasks[0]);
    });

    test('to json #1', () {
      final json = taskModels[1].toJson();

      expect(json, jsonTasks[1]);
    });

    test('to json #2', () {
      final json = taskModels[2].toJson();

      expect(json, jsonTasks[2]);
    });

    test('from json #0', () {
      final task = TaskModel.fromJson(jsonTasks[0]);

      expect(task, taskModels[0]);
    });

    test('from json #1', () {
      final task = TaskModel.fromJson(jsonTasks[1]);

      expect(task, taskModels[1]);
    });

    test('from json #2', () {
      final task = TaskModel.fromJson(jsonTasks[2]);

      expect(task, taskModels[2]);
    });

    test('from json #1', () {
      final task = TaskModel.fromJson(jsonTasks[0]);

      expect(task, taskModels[0]);
    });
  });
}
