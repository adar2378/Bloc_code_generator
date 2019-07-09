// this was auto-generated by Bloc-Code-Generator
// If you want to use rxdart then remove the commented part of the code 
// and also comment the part above the previously commented one 
/// for example : comment this-> [final inputController = StreamController<InputMap>();]
/// and uncomment this -> [//final inputController = BehaviorSubject<InputMap>();]
// also don't forget to uncomment the import of rxdart

//import 'package:rxdart/rxdart.dart';
import 'dart:async';
import 'package:meta/meta.dart';

class CounterBloc {
  final inputController = StreamController<InputMap>();
  //final inputController = BehaviorSubject<InputMap>();
  final outputController = StreamController<OutputMap>();
  //final outputController = BehaviorSubject<OutputMap>();

  Sink<InputMap> get inputSink => inputController.sink; // use the 'inputSink' to add data
  Stream<OutputMap> get outputStream => outputController.stream; // listen to the 'outputStream' to detect changes in data
  //Observable<OutputMap> get outputStream => outputController.stream;

  CounterBloc() {
    inputController.stream.listen(eventDispather);
  }
  eventDispather(InputMap inputMap) {
    if (inputMap.event == Event.increment) {
      inputMap.value++;
    } else if (inputMap.event == Event.decrement) {
      inputMap.value--;
    }
    outputController.add(OutputMap(value: inputMap.value, state: ScreenState.idle));
  }

  dispose() {
    inputController.close();
    outputController.close();
  }
}

enum Event { increment, decrement } // The events that may dispatch, you can edit as you wish

enum ScreenState { idle, loading } // The state of the screen or app, you can edit as you wish

class InputMap {
  /// I strongly recommend to change the type from dynamic to your preffered one. for example: [int value];
  dynamic value;
  Event event;
  InputMap({@required this.value, @required this.event});
}

class OutputMap {
  /// I strongly recommend to change the type from dynamic to your preffered one. for example: [int value];
  dynamic value;
  ScreenState state;
  OutputMap({@required this.value, @required this.state});
}