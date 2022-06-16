import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_7guis/components/temperature_converter_bloc.dart';

class TemperatureConverter extends StatelessWidget {
  const TemperatureConverter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TemperatureConverterBloc(),
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            _Editor(Degrees.C),
            SizedBox(height: 10),
            _Editor(Degrees.F),
          ],
        ),
      ),
    );
  }
}

class _Editor extends StatefulWidget {
  const _Editor(this.D, {Key? key}) : super(key: key);

  final Degrees D;

  @override
  State<_Editor> createState() => _EditorState();
}

class _EditorState extends State<_Editor> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  bool get _isCelsius => widget.D == Degrees.C;

  String get _label => _isCelsius ? "Celsius" : "Fahrenheit";

  ConverterEvent _event(String value) =>
      _isCelsius ? SetCelsiusEvent(value) : SetFahrenheitEvent(value);

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<TemperatureConverterBloc>();
    final error = _isCelsius ? bloc.state.errorC : bloc.state.errorF;

    return Row(
      children: [
        SizedBox(
          width: 100,
          child: Text(_label),
        ),
        Expanded(
          child: BlocListener<TemperatureConverterBloc, ConverterState>(
            listener: (context, state) {
              final newText = _isCelsius ? state.C : state.F;
              if (newText != controller.text) {
                controller.text = newText;
              }
            },
            child: TextField(
              controller: controller,
              onChanged: (value) => bloc.add(_event(value)),
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                filled: error,
                fillColor: const Color.fromARGB(116, 255, 17, 0),
              ),
            ),
          ),
        )
      ],
    );
  }
}
