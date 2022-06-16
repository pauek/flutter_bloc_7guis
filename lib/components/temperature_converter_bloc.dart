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

class ConverterState {
  final String C, F;
  final bool errorC, errorF;

  ConverterState({
    required this.C,
    required this.F,
    required this.errorC,
    required this.errorF,
  });

  ConverterState copyWith({
    String? C,
    String? F,
    bool? errorC,
    bool? errorF,
  }) {
    return ConverterState(
      C: C ?? this.C,
      F: F ?? this.F,
      errorC: errorC ?? this.errorC,
      errorF: errorF ?? this.errorF,
    );
  }
}

class TemperatureConverterBloc extends Bloc<ConverterEvent, ConverterState> {
  TemperatureConverterBloc()
      : super(ConverterState(
          C: "",
          F: "",
          errorC: false,
          errorF: false,
        )) {
    on<SetCelsiusEvent>(_setCelsius);
    on<SetFahrenheitEvent>(_setFahrenheit);
  }

  void _setCelsius(SetCelsiusEvent event, Emitter<ConverterState> emit) {
    if (event.value.isEmpty) {
      return emit(state.copyWith(C: "", errorC: false));
    }
    double? C = double.tryParse(event.value);
    if (C == null) {
      return emit(state.copyWith(C: event.value, errorC: true));
    }
    double F = C * (9.0 / 5.0) + 32.0;
    emit(ConverterState(
      C: event.value,
      errorC: false,
      F: F.toStringAsFixed(2),
      errorF: false,
    ));
  }

  void _setFahrenheit(SetFahrenheitEvent event, Emitter<ConverterState> emit) {
    if (event.value.isEmpty) {
      return emit(state.copyWith(F: "", errorF: false));
    }
    double? F = double.tryParse(event.value);
    if (F == null) {
      return emit(state.copyWith(F: event.value, errorF: true));
    }
    double C = (F - 32.0) * (5.0 / 9.0);
    emit(ConverterState(
      C: C.toStringAsFixed(2),
      errorC: false,
      F: event.value,
      errorF: false,
    ));
  }
}
