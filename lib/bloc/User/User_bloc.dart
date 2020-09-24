import 'dart:async';
import 'dart:developer' as developer;

import 'package:bloc/bloc.dart';
import 'package:flutter_github_connect/bloc/User/index.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(LoadingUserState());

  @override
  Future<void> close() async {
    // dispose objects
    await super.close();
  }

  @override
  Stream<UserState> mapEventToState(
    UserEvent event,
  ) async* {
    try {
       if (event is OnLoad) {
        if (event.isLoadNextRepositories) {
          yield* event.getNextRepositories(currentState: state, bloc: this);
        } else {
          yield* event.getUser(currentState: state, bloc: this);
        }
      }
    } catch (_, stackTrace) {
      developer.log('$_', name: 'UserBloc', error: _, stackTrace: stackTrace);
      yield state;
    }
  }
}
