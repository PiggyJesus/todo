import 'dart:async';

import 'package:bloc/bloc.dart';

part 'importance_color_event.dart';
part 'importance_color_state.dart';

class ColorBloc extends Bloc<ColorEvent, ColorState> {
  ColorBloc() : super(ColorInitState()) {
    on<ColorUpdateEvent>(_update);
  }

  FutureOr<void> _update(ColorUpdateEvent event, Emitter<ColorState> emit) {
    emit(ColorLoadedState(_castColor(event.color)));
  }

  ImportanceColor _castColor(String color) {
    if (color == "red") return ImportanceColor.red;
    return ImportanceColor.purple;
  }
}

enum ImportanceColor { red, purple }
