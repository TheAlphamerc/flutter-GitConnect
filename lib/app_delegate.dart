import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocDelegate extends BlocDelegate {
  @override
  void onEvent(Bloc bloc, dynamic event) {
    super.onEvent(bloc, event);
    // debugPrint("[Trigger Event] $event");
    if(event.props != null){
      event.props.forEach((x){
        print(x);
      });
    }
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    debugPrint(transition.toString());
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
    // GetIt.instance<ErrorsProducer>().pushError(error, stacktrace);
    debugPrint(error.toString());
    debugPrint(stacktrace.toString());
  }
}