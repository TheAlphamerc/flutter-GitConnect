import 'dart:async';
import 'dart:developer' as developer;

import 'package:bloc/bloc.dart';
import 'package:flutter_github_connect/bloc/repo/index.dart';

class RepoBloc extends Bloc<RepoEvent, RepoState> {
  // todo: check singleton for logic in project
  static final RepoBloc _repoBlocSingleton = RepoBloc._internal();
  factory RepoBloc() {
    return _repoBlocSingleton;
  }
  RepoBloc._internal();

  @override
  Future<void> close() async {
    // dispose objects
    await super.close();
  }

  @override
  RepoState get initialState => LoadingUserState();

  @override
  Stream<RepoState> mapEventToState(
    RepoEvent event,
  ) async* {
    try {
      yield* event.getRepositoryAsync(currentState: state, bloc: this);
    } catch (_, stackTrace) {
      developer.log('$_', name: 'RepoBloc', error: _, stackTrace: stackTrace);
      yield state;
    }
  }
}
