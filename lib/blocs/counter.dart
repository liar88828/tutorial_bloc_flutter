import 'dart:async';

class OldCounterBloc {
  int _counter = 0;
  int get counter => _counter;

  final StreamController _inputController = StreamController();
  StreamSink get reducer => _inputController.sink;

  final StreamController _outController = StreamController();
  StreamSink get _sinkOut => _outController.sink;

  Stream get output => _outController.stream;

  OldCounterBloc() {
    _inputController.stream.listen((event) {
      if (event == 'ADD') {
        _counter++;
      }
      if (event == "LESS") {
        _counter--;
      }
      _sinkOut.add(_counter);
      //   _sinkIn.close();
    });
  }

  void dispose() {
    _inputController.close();
    _outController.close();
  }
}
