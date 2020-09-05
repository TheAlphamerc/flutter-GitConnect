import 'dart:async';
import 'dart:developer' as developer;

import 'package:equatable/equatable.dart';
import 'package:flutter_github_connect/bloc/issues/index.dart';
import 'package:flutter_github_connect/resources/gatway/api_gatway.dart';
import 'package:flutter_github_connect/resources/repository/issues_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

@immutable
abstract class IssuesEvent extends Equatable {
  @override
  List<Object> get props => [];
  Stream<IssuesState> applyAsync({IssuesState currentState, IssuesBloc bloc});
  final IssuesRepository _issuesRepository =
      IssuesRepository(apiGatway: GetIt.instance<ApiGateway>());
}

class LoadIssuesEvent extends IssuesEvent {
  final String login;
  final bool isLoadNextRepositories;

  LoadIssuesEvent(this.login, {this.isLoadNextRepositories = false});
  @override
  Stream<IssuesState> applyAsync(
      {IssuesState currentState, IssuesBloc bloc}) async* {
    try {
      if (currentState is LoadedIssuesState) {
        return;
      }
      yield LoadingUserState();
      final issues = await _issuesRepository.getIssues(login: login);
      yield LoadedIssuesState(issues);
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'LoadIssuesEvent', error: _, stackTrace: stackTrace);
      yield ErrorIssuesState(_?.toString());
    }
  }

  Stream<IssuesState> getNextIssues(
      {IssuesState currentState, IssuesBloc bloc}) async* {
    try {
      final state = currentState as LoadedIssuesState;
      if (!state.issues.pageInfo.hasNextPage) {
        print("No repository left");
        return;
      }
      yield LoadingNextIssuessState(state.issues);
      final issuesModel = await _issuesRepository.getIssues(
          login: login, endCursor: state.issues.pageInfo.endCursor);
      yield LoadedIssuesState.getNextIssues(
        currentIssueModel: state.issues,
        issuesModel: issuesModel,
      );
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'LoadUserEvent', error: _, stackTrace: stackTrace);
      final state = currentState as LoadedIssuesState;
      yield ErrorNextIssuessState(
          errorMessage: _?.toString(), issues: state.issues);
    }
  }
}
