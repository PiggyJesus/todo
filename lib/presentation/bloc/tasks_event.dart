part of 'tasks_bloc.dart';

class TasksEvent {}

class TaskInsertEvent extends TasksEvent {
  TaskModel task;

  TaskInsertEvent(this.task);
}

class TaskUpdateEvent extends TasksEvent {
  TaskModel task;
  int id;

  TaskUpdateEvent(this.task, this.id);
}

class TaskDeleteEvent extends TasksEvent {
  int id;

  TaskDeleteEvent(this.id);
}

class TaskVisibleChangeEvent extends TasksEvent {
  TaskVisibleChangeEvent();
}
