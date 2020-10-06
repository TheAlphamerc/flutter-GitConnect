import 'package:equatable/equatable.dart';
import 'package:flutter_github_connect/bloc/commit/commit_model.dart';

abstract class CommitState extends Equatable {
  @override
  List<Object> get props => ([]);
}

class LoadingCommitState extends CommitState {}

/// Initialized
class LoadedCommitState extends CommitState {
  final History history;

  LoadedCommitState(this.history);

  @override
  String toString() => 'LoadedCommitState';

  factory LoadedCommitState.next({History currentHistoryModel, History historyModel}) {
    currentHistoryModel.edges.addAll(historyModel.edges);
    currentHistoryModel.pageInfo = historyModel.pageInfo;
    return LoadedCommitState(currentHistoryModel);
  }

  bool get isNotNullEmpty => this.history.edges != null &&
                this.history.edges.isNotEmpty;
}

class ErrorCommitState extends CommitState {
  final String errorMessage;

  ErrorCommitState(this.errorMessage);

  @override
  String toString() => 'ErrorCommitState';
}

class LoadingNextCommitState extends LoadedCommitState {
  LoadingNextCommitState(History history) : super(history);
}

class ErrorNextIssuessState extends LoadedCommitState {
  final String errorMessage;

  ErrorNextIssuessState({this.errorMessage,History history}): super(history);

  @override
  String toString() => 'ErrorNextIssuessState';
}