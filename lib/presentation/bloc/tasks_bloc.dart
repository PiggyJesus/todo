import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:todo/domain/models/task_model.dart';
import 'package:todo/data/repository/repository.dart';
import 'package:todo/domain/repository/task_repository.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  late final TaskRepository repository = Repository();
  List<TaskModel> data = [];
  int doneCount = 0;
  bool visible = true;

  TasksBloc() : super(TasksInitState()) {
    on<TaskLoadEvent>(_load);
    on<TaskInsertEvent>(_insert);
    on<TaskUpdateEvent>(_update);
    on<TaskDeleteEvent>(_delete);
    on<TaskVisibleChangeEvent>(_visibleChange);

    add(TaskLoadEvent());
  }

  FutureOr<void> _insert(
      TaskInsertEvent event, Emitter<TasksState> emit) async {
    emit(TasksLoadingState());

    data.add(event.task);
    if (event.task.done) doneCount++;

    emit(TasksLoadedState());

    final result = await repository.insert(event.task);

    if (!result) {
      add(TaskLoadEvent());
    }
  }

  FutureOr<void> _update(
      TaskUpdateEvent event, Emitter<TasksState> emit) async {
    emit(TasksLoadingState());

    if (data[event.id].done && !event.task.done) doneCount--;
    if (!data[event.id].done && event.task.done) doneCount++;

    data[event.id] = event.task;

    emit(TasksLoadedState());

    final result = await repository.update(event.task);

    if (!result) {
      add(TaskLoadEvent());
    }
  }

  FutureOr<void> _delete(
      TaskDeleteEvent event, Emitter<TasksState> emit) async {
    emit(TasksLoadingState());

    String uuid = data[event.id].uuid;
    if (data[event.id].done) doneCount--;
    data.removeAt(event.id);

    emit(TasksLoadedState());

    final result = await repository.delete(uuid);

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

    data = await repository.getAll();
    doneCount = 0;
    for (var task in data) {
      if (task.done) {
        doneCount++;
      }
    }

    emit(TasksLoadedState());
  }
}
