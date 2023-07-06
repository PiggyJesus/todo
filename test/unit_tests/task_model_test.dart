import 'package:flutter_test/flutter_test.dart';
import 'package:todo/domain/models/importance.dart';
import 'package:todo/domain/models/task_model.dart';

import '../data/test_tasks.dart';

void main() {
  group('create tests', () {
    test('test #1', () {
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

    test('test #2', () {
      final task = TaskModel(
        uuid: '1',
        name: 'test №2',
        importance: Importance.high,
        createdAt: DateTime(2023, 07, 05, 18, 15, 35, 280),
        changedAt: DateTime(2023, 07, 05, 18, 15, 38, 470),
        lastUpdatedBy: '321',
        deadline: DateTime(2023, 07, 10),
      );

      expect(task.uuid, '1');
      expect(task.name, 'test №2');
      expect(task.importance, Importance.high);
      expect(task.createdAt, DateTime(2023, 07, 05, 18, 15, 35, 280));
      expect(task.changedAt, DateTime(2023, 07, 05, 18, 15, 38, 470));
      expect(task.lastUpdatedBy, '321');
      expect(task.done, false);
      expect(task.color, null);
      expect(task.deadline, DateTime(2023, 07, 10));
      expect(task.deleted, false);
    });

    test('test #3', () {
      final task = TaskModel(
        uuid: 'someId',
        name: 'test #3',
        importance: Importance.low,
        createdAt: DateTime(2023, 07, 05, 18, 15, 35, 280),
        changedAt: DateTime(2222),
        lastUpdatedBy: 'me',
        deleted: true,
        done: false,
      );

      expect(task.uuid, "someId");
      expect(task.name, "test #3");
      expect(task.importance, Importance.low);
      expect(task.createdAt, DateTime(2023, 07, 05, 18, 15, 35, 280));
      expect(task.changedAt, DateTime(2222));
      expect(task.lastUpdatedBy, "me");
      expect(task.done, false);
      expect(task.color, null);
      expect(task.deadline, null);
      expect(task.deleted, true);
    });
  });

  group('to json tests', () {
    test('test #0', () {
      final json = taskModels[0].toJson();

      expect(json, jsonTasks[0]);
    });

    test('test #1', () {
      final json = taskModels[1].toJson();

      expect(json, jsonTasks[1]);
    });

    test('test #2', () {
      final json = taskModels[2].toJson();

      expect(json, jsonTasks[2]);
    });});

  group('from json tests', () {
    test('test #0', () {
      final task = TaskModel.fromJson(jsonTasks[0]);

      expect(task, taskModels[0]);
    });

    test('test #1', () {
      final task = TaskModel.fromJson(jsonTasks[1]);

      expect(task, taskModels[1]);
    });

    test('test #2', () {
      final task = TaskModel.fromJson(jsonTasks[2]);

      expect(task, taskModels[2]);
    });
  });
}
