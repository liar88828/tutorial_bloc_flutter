part of 'color_bloc.dart';

@immutable
sealed class ColorEvent {}

class ColorIncrementEvent extends ColorEvent {}

class ColorDecrementEvent extends ColorEvent {}

class ColorResetEvent extends ColorEvent {}
