import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:todo/presentation/utils/task_model.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  List<TaskModel> data = [];
  int doneCount = 0;
  bool visible = true;

  TasksBloc() : super(TasksInitState()) {
    on<TaskInsertEvent>(_insert);
    on<TaskUpdateEvent>(_update);
    on<TaskDeleteEvent>(_delete);
    on<TaskVisibleChangeEvent>(_visibleChange);
  }

  FutureOr<void> _insert(TaskInsertEvent event, Emitter<TasksState> emit) {
    emit(TasksLoadingState());

    data.add(event.task);
    if (event.task.isDone) doneCount++;

    emit(TasksLoadedState());
  }

  FutureOr<void> _update(TaskUpdateEvent event, Emitter<TasksState> emit) {
    emit(TasksLoadingState());

    if (data[event.id].isDone && !event.task.isDone) doneCount--;
    if (!data[event.id].isDone && event.task.isDone) doneCount++;

    data[event.id] = event.task;

    emit(TasksLoadedState());
  }

  FutureOr<void> _delete(TaskDeleteEvent event, Emitter<TasksState> emit) {
    emit(TasksLoadingState());

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
}
