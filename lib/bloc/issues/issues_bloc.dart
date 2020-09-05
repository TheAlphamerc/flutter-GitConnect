import 'dart:async';
import 'dart:developer' as developer;

import 'package:bloc/bloc.dart';
import 'package:flutter_github_connect/bloc/issues/index.dart';

class IssuesBloc extends Bloc<IssuesEvent, IssuesState> {
  IssuesBloc() : super(LoadingUserState());

  @override
  Stream<IssuesState> mapEventToState(
    IssuesEvent event,
  ) async* {
    try {
      if(event is LoadIssuesEvent){
        if(event.isLoadNextIssues){
          yield* event.getNextIssues(currentState: state, bloc: this);
        }else{
          yield* event.applyAsync(currentState: state, bloc: this);
        }
      }
    } catch (_, stackTrace) {
      developer.log('$_', name: 'IssuesBloc', error: _, stackTrace: stackTrace);
      yield state;
    }
  }
}
