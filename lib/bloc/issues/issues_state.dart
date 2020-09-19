import 'package:equatable/equatable.dart';
import 'package:flutter_github_connect/bloc/issues/issues_model.dart';

abstract class IssuesState extends Equatable {
  @override
  List<Object> get props => ([]);
}

class LoadingUserIssuesState extends IssuesState {}

/// Initialized
class LoadedIssuesState extends IssuesState {
  final Issues issues;

  LoadedIssuesState(this.issues);

  @override
  String toString() => 'LoadedIssuesState';

  factory LoadedIssuesState.next({Issues currentIssueModel, Issues issuesModel}) {
      currentIssueModel.list.addAll(issuesModel.list);
    currentIssueModel.pageInfo = issuesModel.pageInfo;
    return LoadedIssuesState(currentIssueModel);
  }
}

class ErrorIssuesState extends IssuesState {
  final String errorMessage;

  ErrorIssuesState(this.errorMessage);

  @override
  String toString() => 'ErrorIssuesState';
}

class LoadingNextIssuessState extends LoadedIssuesState {
  LoadingNextIssuessState(Issues issues) : super(issues);
}

class ErrorNextIssuessState extends LoadedIssuesState {
  final String errorMessage;

  ErrorNextIssuessState({this.errorMessage,Issues issues}) : super(issues);
}

class LoadingRepoIssuesState extends IssuesState {}

/// Initialized
class LoadedRepoIssuesState extends IssuesState {
  final Issues issues;

  LoadedRepoIssuesState(this.issues);

  @override
  String toString() => 'LoadedRepoIssuesState';

  factory LoadedRepoIssuesState.next({Issues currentIssueModel, Issues issuesModel}) {
      currentIssueModel.list.addAll(issuesModel.list);
    currentIssueModel.pageInfo = issuesModel.pageInfo;
    return LoadedRepoIssuesState(currentIssueModel);
  }
}

class ErrorRepoIssuesState extends IssuesState {
  final String errorMessage;

  ErrorRepoIssuesState(this.errorMessage);

  @override
  String toString() => 'ErrorRepoIssuesState';
}

class LoadingNextRepoIssuessState extends LoadedRepoIssuesState {
  LoadingNextRepoIssuessState(Issues issues) : super(issues);
}

class ErrorNextRepoIssuessState extends LoadedRepoIssuesState {
  final String errorMessage;

  ErrorNextRepoIssuessState({this.errorMessage,Issues issues}) : super(issues);
}