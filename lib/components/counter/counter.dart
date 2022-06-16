import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_7guis/components/counter/counter_bloc.dart';

class Counter extends StatelessWidget {
  const Counter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CounterBloc(),
      child: const _Counter(),
    );
  }
}

class _Counter extends StatelessWidget {
  const _Counter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Button(icon: Icons.remove, event: DecrementEvent()),
            const SizedBox(width: 12),
            SizedBox(
              width: 150,
              child: Text(
                context.watch<CounterBloc>().state.count.toString(),
                style: Theme.of(context).textTheme.headline1,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(width: 12),
            Button(icon: Icons.add, event: IncrementEvent()),
          ],
        ),
        Align(
          alignment: Alignment.centerRight,
          child: IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => context.read<CounterBloc>().add(ResetEvent()),
            tooltip: "Reset",
          ),
        )
      ],
    );
  }
}

class Button extends StatelessWidget {
  const Button({
    Key? key,
    required this.icon,
    required this.event,
  }) : super(key: key);

  final IconData icon;
  final CounterEvent event;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<CounterBloc>();
    return SizedBox(
      width: 68,
      height: 68,
      child: Material(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        child: Center(
          child: Ink(
            decoration: const ShapeDecoration(
              color: Colors.blue,
              shape: CircleBorder(),
            ),
            child: IconButton(
              iconSize: 32,
              icon: Icon(icon, color: Colors.white),
              onPressed: () => bloc.add(event),
            ),
          ),
        ),
      ),
    );
  }
}
