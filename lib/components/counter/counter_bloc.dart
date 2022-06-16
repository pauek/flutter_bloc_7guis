import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';

abstract class CounterEvent {}

class IncrementEvent extends CounterEvent {}

class DecrementEvent extends CounterEvent {}

class ResetEvent extends CounterEvent {}

class CounterState {
  int count = 0;
  CounterState({required this.count});
}

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(CounterState(count: 0)) {
    on<IncrementEvent>(_increment);
    on<DecrementEvent>(_decrement);
    on<ResetEvent>(_reset);
  }

  _increment(IncrementEvent event, Emitter<CounterState> emit) {
    emit(CounterState(count: min(99, state.count + 1)));
  }

  _decrement(DecrementEvent event, Emitter<CounterState> emit) {
    emit(CounterState(count: max(-9, state.count - 1)));
  }

  _reset(ResetEvent event, Emitter<CounterState> emit) {
    emit(CounterState(count: 0));
  }
}
