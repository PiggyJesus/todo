import 'package:todo/domain/models/importance.dart';
import 'package:todo/domain/models/task_model.dart';

const List<Map<String, dynamic>> jsonTasks = [
  {
    'id': 'ca6bff00-1b46-11ee-89fe-53adf2c1d030',
    'text': 'ннн',
    'importance': 'basic',
    'created_at': 1688570135280,
    'changed_at': 1688570138470,
    'last_updated_by': '123',
    'deadline': null,
    'done': true,
    'color': null,
  },
  {
    'id': 'f74f88f0-1b5c-11ee-bf5b-970af7f5bf13',
    'text': 'дтм',
    'importance': 'low',
    'created_at': 1688579659520,
    'changed_at': 1688579785150,
    'last_updated_by': '123',
    'deadline': 1689973200000,
    'done': true,
    'color': null,
  },
  {
    'id': '15019dc0-1b5d-11ee-bf5b-970af7f5bf13',
    'text': '1',
    'importance': 'basic',
    'created_at': 1688579709341,
    'changed_at': 1688579711775,
    'last_updated_by': '123',
    'deadline': null,
    'done': false,
    'color': null,
  },
];

List<TaskModel> taskModels = [
  TaskModel(
    uuid: 'ca6bff00-1b46-11ee-89fe-53adf2c1d030', 
    name: 'ннн', 
    importance: Importance.common, 
    createdAt: DateTime(2023, 07, 05, 18, 15, 35, 280), 
    changedAt: DateTime(2023, 07, 05, 18, 15, 38,  470),
    lastUpdatedBy: '123', 
    done: true, 
  ), 
  TaskModel(
    uuid: 'f74f88f0-1b5c-11ee-bf5b-970af7f5bf13', 
    name: 'дтм', 
    importance: Importance.low, 
    createdAt: DateTime(2023, 07, 05, 20, 54, 19, 520), 
    changedAt: DateTime(2023, 07, 05, 20, 56, 25, 150),
    lastUpdatedBy: '123', 
    deadline: DateTime(2023, 07, 22, 00, 00, 00, 000),
    done: true,
    deleted: false,
  ),
  TaskModel(
    uuid: '15019dc0-1b5d-11ee-bf5b-970af7f5bf13',
    name: '1', 
    importance: Importance.common, 
    createdAt: DateTime(2023, 07, 05, 20, 55, 09, 341),
    changedAt: DateTime(2023, 07, 05, 20, 55, 11, 775),
    lastUpdatedBy: '123', 
    done: false,
    deleted: false,
  ),
];

