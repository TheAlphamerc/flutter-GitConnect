import 'dart:async';
import 'dart:developer' as developer;

import 'package:bloc/bloc.dart';
import 'package:flutter_github_connect/bloc/navigation/index.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  @override
  NavigationState get initialState => SelectPageIndex(0);

  @override
  Stream<NavigationState> mapEventToState(NavigationEvent event) async* {
    if (event is IndexSelected) {
      yield SelectPageIndex(event.index);
    }
     else {
      throw UnsupportedError('Unsupported event $event');
    }
  }
}