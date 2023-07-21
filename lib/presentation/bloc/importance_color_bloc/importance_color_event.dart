part of 'importance_color_bloc.dart';

class ColorEvent {}

class ColorUpdateEvent extends ColorEvent {
  String color;
  ColorUpdateEvent(this.color);
}
