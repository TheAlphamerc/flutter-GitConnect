import 'dart:async';
import 'dart:developer' as developer;

import 'package:bloc/bloc.dart';
import 'package:flutter_github_connect/bloc/notification/index.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {

  @override
  NotificationState get initialState => LoadingNotificationState();

  @override
  Stream<NotificationState> mapEventToState(
    NotificationEvent event,
  ) async* {
    try {
      if(event is OnLoad){
          yield* event.getNotificationList(currentState: state, bloc: this);
      }
    } catch (_, stackTrace) {
      developer.log('$_', name: 'NotificationBloc', error: _, stackTrace: stackTrace);
      yield state;
    }
  }
}