import 'dart:async';
import 'dart:developer' as developer;

import 'package:equatable/equatable.dart';
import 'package:flutter_github_connect/bloc/commit/index.dart';
import 'package:flutter_github_connect/resources/gatway/api_gatway.dart';
import 'package:flutter_github_connect/resources/repository/repo_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

@immutable
abstract class CommitEvent extends Equatable {
  @override
  List<Object> get props => [];
  final RepoRepository _repoRepository =   RepoRepository(apiGatway: GetIt.instance<ApiGateway>());
  Stream<CommitState> getCommits({CommitState currentState, CommitBloc bloc})async*{}
  Stream<CommitState> getNextCommits({CommitState currentState, CommitBloc bloc}) async*{}
}

class LoadCommitsEvent extends CommitEvent {
   final String name;
   final String owner;
   final int count;
   final bool isLoadNextCommit;

  LoadCommitsEvent(this.name, this.owner,{this.count,this.isLoadNextCommit = false});
  @override
  Stream<CommitState> getCommits({CommitState currentState, CommitBloc bloc}) async* {
    try {
      yield LoadingCommitState();
      final history = await _repoRepository.fetchCommits(name: name, owner: owner);
      yield LoadedCommitState(history);
    } catch (_, stackTrace) {
      developer.log('$_', name: 'LoadCommitEvent', error: _, stackTrace: stackTrace);
      yield ErrorCommitState( _?.toString());
    }
  }

  Stream<CommitState> getNextCommits({CommitState currentState, CommitBloc bloc}) async* {
    try {
      final state = currentState as LoadedCommitState;
      if (!state.history.pageInfo.hasNextPage) {
        print("No Issues left");
        return;
      }
      yield LoadingNextCommitState(state.history);
      final historyModel = await _repoRepository.fetchCommits(name: name, owner: owner,endCursor:state.history.pageInfo.endCursor);
      yield LoadedCommitState.next(
        currentHistoryModel: state.history,
        historyModel: historyModel
      );
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'LoadUserEvent', error: _, stackTrace: stackTrace);
      final state = currentState as LoadedCommitState;
      yield ErrorNextIssuessState(
          errorMessage: _?.toString(), history: state.history);
    }
  }
}
