import 'dart:async';
import 'dart:developer' as developer;
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_github_connect/bloc/bloc/repo_response_model.dart';
import 'package:flutter_github_connect/exceptions/exceptions.dart';
import 'package:flutter_github_connect/resources/gatway/api_gatway.dart';
import 'package:flutter_github_connect/resources/repository/repo_repository.dart';
import 'package:get_it/get_it.dart';
part 'repo_event.dart';
part 'repo_state.dart';

class RepoBloc extends Bloc<RepoEvent, RepoState> {
  RepoBloc() : super(LoadingRepoState());

  @override
  Stream<RepoState> mapEventToState(
    RepoEvent event,
  ) async* {
   try {
      yield* event.applyAsync(currentState: state, bloc: this);
    } catch (_, stackTrace) {
      developer.log('$_', name: 'IssuesBloc', error: _, stackTrace: stackTrace);
      yield state;
    }
  }
}
