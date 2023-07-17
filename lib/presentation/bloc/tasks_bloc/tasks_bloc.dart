import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:todo/domain/models/task_model.dart';
import 'package:todo/domain/repository/task_repository.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  late final TaskRepository _repository;
  late final FirebaseAnalytics? _analyticsInstance;
  TaskModel? currentTask;
  bool gotCurrentTask = false;
  Map<String, TaskModel> data = {};
  int doneCount = 0;
  bool visible = true;

  TasksBloc(
    TaskRepository repository, {
    FirebaseAnalytics? analyticsInstance,
  }) : super(TasksInitState()) {
    _repository = repository;
    _analyticsInstance = analyticsInstance;

    on<TaskLoadEvent>(_load);
    on<TaskLoadTaskEvent>(_loadTask);
    on<TaskInsertEvent>(_insert);
    on<TaskUpdateEvent>(_update);
    on<TaskDeleteEvent>(_delete);
    on<TaskVisibleChangeEvent>(_visibleChange);

    add(TaskLoadEvent());
  }

  FutureOr<void> _insert(
      TaskInsertEvent event, Emitter<TasksState> emit) async {
    emit(TasksLoadingState());

    data[event.task.uuid] = event.task;
    if (event.task.done) doneCount++;

    emit(TasksLoadedState());

    if (_analyticsInstance != null) {
      _analyticsInstance!.logEvent(name: "task_add");
    }

    final result = await _repository.insert(event.task);

    if (!result) {
      add(TaskLoadEvent());
    }
  }

  FutureOr<void> _update(
      TaskUpdateEvent event, Emitter<TasksState> emit) async {
    emit(TasksLoadingState());

    if (data[event.uuid]!.done && !event.task.done) {
      doneCount--;

      if (_analyticsInstance != null) {
        _analyticsInstance!.logEvent(name: "task_not_done");
      }
    }
    if (!data[event.uuid]!.done && event.task.done) {
      doneCount++;

      if (_analyticsInstance != null) {
        _analyticsInstance!.logEvent(name: "task_done");
      }
    }

    data[event.uuid] = event.task;

    emit(TasksLoadedState());

    final result = await _repository.update(event.task);

    if (!result) {
      add(TaskLoadEvent());
    }
  }

  FutureOr<void> _delete(
      TaskDeleteEvent event, Emitter<TasksState> emit) async {
    emit(TasksLoadingState());

    if (data[event.uuid]!.done) doneCount--;
    data.remove(event.uuid);

    emit(TasksLoadedState());

    if (_analyticsInstance != null) {
      _analyticsInstance!.logEvent(name: "task_delete");
    }
    final result = await _repository.delete(event.uuid);

    if (!result) {
      add(TaskLoadEvent());
    }
  }

  FutureOr<void> _visibleChange(
      TaskVisibleChangeEvent event, Emitter<TasksState> emit) {
    emit(TasksLoadingState());

    visible = !visible;

    emit(TasksLoadedState());
  }

  FutureOr<void> _load(TaskLoadEvent event, Emitter<TasksState> emit) async {
    emit(TasksLoadingState());

    final listData = await _repository.getAll();
    _initData(listData);

    emit(TasksLoadedState());
  }

  FutureOr<void> _loadTask(
      TaskLoadTaskEvent event, Emitter<TasksState> emit) async {
    emit(TasksLoadingState());

    currentTask = await _repository.getTask(event.uuid);
    gotCurrentTask = currentTask != null;

    emit(TasksLoadedState());
  }

  void _initData(List<TaskModel> listData) {
    doneCount = 0;
    data = {
      for (final task in listData) task.uuid: task,
    };
    for (var task in data.values) {
      if (task.done) {
        doneCount++;
      }
    }
  }
}
