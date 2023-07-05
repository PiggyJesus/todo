part of 'tasks_bloc.dart';

class TasksEvent {}

class TaskLoadEvent extends TasksEvent {
  TaskLoadEvent();
}

class TaskInsertEvent extends TasksEvent {
  TaskModel task;

  TaskInsertEvent(this.task);
}

class TaskUpdateEvent extends TasksEvent {
  TaskModel task;
  late String uuid;

  TaskUpdateEvent(this.task) {
    uuid = task.uuid;
  }
}

class TaskDeleteEvent extends TasksEvent {
  String uuid;

  TaskDeleteEvent(this.uuid);
}

class TaskVisibleChangeEvent extends TasksEvent {
  TaskVisibleChangeEvent();
}
