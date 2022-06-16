import 'package:flutter/material.dart';
import 'package:flutter_bloc_7guis/components/temperature_converter.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300]!,
      body: ListView(
        children: const [
          _GUI(
            title: "Counter",
            child: Text("hey1"),
          ),
          _GUI(
            title: "Temperature Converter",
            child: TemperatureConverter(),
          ),
          _GUI(
            title: "Flight Booker",
            child: Text("hey3"),
          ),
        ],
      ),
    );
  }
}

class _GUI extends StatelessWidget {
  const _GUI({
    Key? key,
    required this.title,
    required this.child,
  }) : super(key: key);

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Text(title, style: Theme.of(context).textTheme.headline4),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: Colors.grey[300]!,
              ),
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(6)),
            ),
            child: child,
          ),
        ],
      ),
    );
  }
}
