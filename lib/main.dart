import 'package:flutter/material.dart';
import 'package:tutorial_bloc/blocs/counter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  CounterBloc bloc = CounterBloc();

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
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
                    bloc.reducer.add("LESS");
                  },
                  icon: Icon(Icons.remove),
                ),
                StreamBuilder(
                    stream: bloc.output,
                    initialData: bloc.counter,
                     builder: (context, snapshot) => Text(
                          '${snapshot.data}',
                          style: Theme.of(context).textTheme.headlineMedium,
                        )),
                IconButton(
                  style: IconButton.styleFrom(backgroundColor: Colors.blue),
                  onPressed: () {
                    bloc.reducer.add("ADD");
                  },
                  icon: Icon(Icons.add),
                )
              ].expand((widget) => [widget, const SizedBox(width: 10)]).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
