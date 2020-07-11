import 'dart:async';
import 'dart:developer' as developer;

import 'package:bloc/bloc.dart';
import 'package:flutter_github_connect/bloc/User/index.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  // todo: check singleton for logic in project
  // static final UserBloc _userBlocSingleton = UserBloc._internal();
  // factory UserBloc() {
  //   return _userBlocSingleton;
  // }
  // UserBloc._internal();

  @override
  Future<void> close() async {
    // dispose objects
    await super.close();
  }

  @override
  UserState get initialState => LoadingUserState();

  @override
  Stream<UserState> mapEventToState(
    UserEvent event,
  ) async* {
    try {
      if(event is OnLoad)
      yield* event.getUser(currentState: state, bloc: this);
    } catch (_, stackTrace) {
      developer.log('$_', name: 'UserBloc', error: _, stackTrace: stackTrace);
      yield state;
    }
  }
}
