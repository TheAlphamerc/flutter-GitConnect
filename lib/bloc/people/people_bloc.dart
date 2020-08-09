import 'dart:async';
import 'dart:developer' as developer;

import 'package:bloc/bloc.dart';
import 'package:flutter_github_connect/bloc/people/index.dart';

class PeopleBloc extends Bloc<PeopleEvent, PeopleState> {
  PeopleBloc() : super(LoadingFollowersState());

  @override
  Stream<PeopleState> mapEventToState(
    PeopleEvent event,
  ) async* {
    try {
      if (event is LoadFollowerEvent) {
        yield* event.fetchFollowersList(currentState: state, bloc: this);
      }
    } catch (_, stackTrace) {
      developer.log('$_', name: 'PeopleBloc', error: _, stackTrace: stackTrace);
      yield state;
    }
  }
}
