import 'dart:async';
import 'dart:developer' as developer;

import 'package:bloc/bloc.dart';
import 'package:flutter_github_connect/bloc/commit/index.dart';

class CommitBloc extends Bloc<CommitEvent, CommitState> {

  CommitBloc() : super(LoadingCommitState());

  @override
  Stream<CommitState> mapEventToState(
    CommitEvent event,
  ) async* {
    try {
      if(event is LoadCommitsEvent){
        if(event.isLoadNextCommit){
          yield* event.getNextCommits(currentState: state, bloc: this);
        }else{
          yield* event.getCommits(currentState: state, bloc: this);
        }
      }
      
    } catch (_, stackTrace) {
      developer.log('$_', name: 'CommitBloc', error: _, stackTrace: stackTrace);
      yield state;
    }
  }
}
