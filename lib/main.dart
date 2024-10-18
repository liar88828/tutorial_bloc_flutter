import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutorial_bloc/color_bloc/color_bloc.dart';
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
    return MultiBlocProvider(
        providers: [
          BlocProvider<CounterBloc>(create: (context) => CounterBloc()),
          BlocProvider<ColorBloc>(create: (context) => ColorBloc())
        ],
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BlocBuilder<ColorBloc, ColorState>(builder: (context, state) {
            return Container(
              color: state.color,
              height: 200,
              width: 200,
            );
          }),
          BlocConsumer<CounterBloc, CounterState>(builder: (context, state) {
            return Text(
              state.counter.toString(),
            );
          }, listener: (context, state) {
            if (state.counter >= 10) {
              const snackBar = SnackBar(
                elevation: 0,
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.transparent,
                content: AwesomeSnackbarContent(
                    title: "Working!!",
                    message: 'This example Bloc Listener!!',
                    contentType: ContentType.help),
              );
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(snackBar);
            }
          }),
          BlocListener<CounterBloc, CounterState>(
            listenWhen: (previous, current) {
              // return false;// will not show the snackbar
              return true;
            },
            listener: (context, state) {
              if (state.counter >= 5) {
                const snackBar = SnackBar(
                  elevation: 0,
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.transparent,
                  content: AwesomeSnackbarContent(
                      title: "Working!!",
                      message: 'This example Bloc Listener!!',
                      contentType: ContentType.success),
                );
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(snackBar);
              }
            },
            child: const Text('Bloc Listener'),
          ),
          const Text(
            'You have pushed the button this many times:',
          ),
          BlocSelector<CounterBloc, CounterState, bool>(
              selector: (state) => state.counter >= 3 ? true : false,
              builder: (context, state) {
                return Center(
                  child: Container(
                    child: IconButton(
                        onPressed: () {
                          context.read<ColorBloc>().add(ColorResetEvent());
                        },
                        icon: Icon(Icons.swap_calls)),
                    color: state ? Colors.green : Colors.red,
                  ),
                );
              }),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                style: IconButton.styleFrom(backgroundColor: Colors.blue),
                onPressed: () {
                  context.read<CounterBloc>().add(CounterDecrementEvent());
                  context.read<ColorBloc>().add(ColorDecrementEvent());
                },
                icon: const Icon(Icons.remove),
              ),
              BlocBuilder<CounterBloc, CounterState>(
                  buildWhen: (previous, current) {
                print(previous.counter);
                print(current.counter);
                return current.counter >= 0;
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
                  context.read<ColorBloc>().add(ColorIncrementEvent());
                },
                icon: const Icon(Icons.add),
              )
            ].expand((widget) => [widget, const SizedBox(width: 10)]).toList(),
          ),
        ],
      ),
    );
  }
}
