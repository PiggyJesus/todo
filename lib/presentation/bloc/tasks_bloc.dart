import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:todo/data/local/repository/local_repository.dart';
import 'package:todo/domain/models/task_model.dart';
import 'package:todo/domain/repository/task_repository.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  final TaskRepository _repository = LocalRepository();
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

    if (await _repository.insert(event.task)) {
      data.add(event.task);
      if (event.task.isDone) doneCount++;
    }

    emit(TasksLoadedState());
  }

  FutureOr<void> _update(
      TaskUpdateEvent event, Emitter<TasksState> emit) async {
    emit(TasksLoadingState());

    if (data[event.id].isDone && !event.task.isDone) doneCount--;
    if (!data[event.id].isDone && event.task.isDone) doneCount++;

    data[event.id] = event.task;
    await _repository.update(event.task);

    emit(TasksLoadedState());
  }

  FutureOr<void> _delete(
      TaskDeleteEvent event, Emitter<TasksState> emit) async {
    emit(TasksLoadingState());

    await _repository.delete(data[event.id].uuid);
    if (data[event.id].isDone) doneCount--;
    data.removeAt(event.id);

    emit(TasksLoadedState());
  }

  FutureOr<void> _visibleChange(
      TaskVisibleChangeEvent event, Emitter<TasksState> emit) {
    emit(TasksLoadingState());

    visible = !visible;

    emit(TasksLoadedState());
  }

  FutureOr<void> _load(TaskLoadEvent event, Emitter<TasksState> emit) async {
    emit(TasksLoadingState());

    data = await _repository.getAll();
    doneCount = 0;
    for (var task in data) {
      if (task.isDone) {
        doneCount++;
      }
    }

    emit(TasksLoadedState());
  }
}
