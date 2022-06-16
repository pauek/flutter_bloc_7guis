import 'package:flutter_bloc/flutter_bloc.dart';

enum Degrees { C, F }

abstract class ConverterEvent {}

class SetEvent extends ConverterEvent {
  String value;
  SetEvent(this.value);
}

class SetCelsiusEvent extends SetEvent {
  SetCelsiusEvent(super.value);
}

class SetFahrenheitEvent extends SetEvent {
  SetFahrenheitEvent(super.value);
}

class Temp {
  String value;
  bool error;
  Temp([this.value = "", this.error = false]);
}

class ConverterState {
  final Temp C, F;

  ConverterState({required this.C, required this.F});

  ConverterState copyWith({Temp? C, Temp? F}) {
    return ConverterState(C: C ?? this.C, F: F ?? this.F);
  }
}

class TemperatureConverterBloc extends Bloc<ConverterEvent, ConverterState> {
  TemperatureConverterBloc() : super(ConverterState(C: Temp(), F: Temp())) {
    on<SetCelsiusEvent>(_setCelsius);
    on<SetFahrenheitEvent>(_setFahrenheit);
  }

  void _setCelsius(SetCelsiusEvent event, Emitter<ConverterState> emit) {
    if (event.value.isEmpty) {
      return emit(state.copyWith(C: Temp("", false)));
    }
    double? C = double.tryParse(event.value);
    if (C == null) {
      return emit(state.copyWith(C: Temp(event.value, true)));
    }
    double F = C * (9.0 / 5.0) + 32.0;
    emit(ConverterState(
      C: Temp(event.value, false),
      F: Temp(F.toStringAsFixed(2), false),
    ));
  }

  void _setFahrenheit(SetFahrenheitEvent event, Emitter<ConverterState> emit) {
    if (event.value.isEmpty) {
      return emit(state.copyWith(F: Temp("", false)));
    }
    double? F = double.tryParse(event.value);
    if (F == null) {
      return emit(state.copyWith(F: Temp(event.value, true)));
    }
    double C = (F - 32.0) * (5.0 / 9.0);
    emit(ConverterState(
      C: Temp(C.toStringAsFixed(2), false),
      F: Temp(event.value, false),
    ));
  }
}
