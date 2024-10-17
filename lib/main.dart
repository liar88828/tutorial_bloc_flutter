import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutorial_bloc/counter_bloc/counter_bloc.dart';
import 'package:tutorial_bloc/counter_bloc/counter_event.dart';
import 'package:tutorial_bloc/counter_bloc/counter_state.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<CounterBloc>(
        create: (context) => CounterBloc(),
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const MyHome(),
        ));
  }
}

class MyHome extends StatelessWidget {
  const MyHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('My Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  style: IconButton.styleFrom(backgroundColor: Colors.blue),
                  onPressed: () {
                    context.read<CounterBloc>().add(CounterDecrementEvent());
                  },
                  icon: const Icon(Icons.remove),
                ),
                BlocBuilder<CounterBloc, CounterState>(
                    buildWhen: (previous, current) {
                  print(previous.counter);
                  print(current.counter);
                  return current.counter>=0;
                  // return true; // will run
                  // return false; // not run
                }, builder: (context, state) {
                  return Text(
                    state.counter.toString(),
                    style: Theme.of(context).textTheme.headlineMedium,
                  );
                }),
                IconButton(
                  style: IconButton.styleFrom(backgroundColor: Colors.blue),
                  onPressed: () {
                    context.read<CounterBloc>().add(CounterIncrementEvent());
                  },
                  icon: const Icon(Icons.add),
                )
              ]
                  .expand((widget) => [widget, const SizedBox(width: 10)])
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
