part of 'importance_color_bloc.dart';

class ColorState {}

class ColorInitState extends ColorState {}

class ColorLoadedState extends ColorState {
  ImportanceColor color;
  ColorLoadedState(this.color);
}
