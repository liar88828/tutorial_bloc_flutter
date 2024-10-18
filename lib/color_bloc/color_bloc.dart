import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'color_event.dart';
part 'color_state.dart';

class ColorBloc extends Bloc<ColorEvent, ColorState> {
  ColorBloc() : super(ColorInitialState()) {
    on<ColorIncrementEvent>((event, emit) {
      emit(ColorIncrementState(Colors.green));
    });

    on<ColorDecrementEvent>((event, emit) {
      emit(ColorDecrementState(Colors.red));
    });

    on<ColorResetEvent>((event, emit) {
      emit(ColorResetState());
    });
  }
}
