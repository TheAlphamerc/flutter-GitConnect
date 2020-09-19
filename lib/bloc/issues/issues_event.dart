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
  
  final IssuesRepository _issuesRepository =IssuesRepository(apiGatway: GetIt.instance<ApiGateway>());
  @override
  Stream<IssuesState> loadIssues({IssuesState currentState, IssuesBloc bloc})async*{}
  @override
  Stream<IssuesState> loadRepoIssues({IssuesState currentState, IssuesBloc bloc})async*{}
}

class LoadIssuesEvent extends IssuesEvent {
  final String login;
  final bool isLoadNextIssues;

  LoadIssuesEvent(this.login, {this.isLoadNextIssues = false});
  @override
  Stream<IssuesState> loadIssues(
      {IssuesState currentState, IssuesBloc bloc}) async* {
    try {
      if (currentState is LoadedIssuesState) {
        return;
      }
      yield LoadingUserIssuesState();
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
        print("No Issues left");
        return;
      }
      yield LoadingNextIssuessState(state.issues);
      final issuesModel = await _issuesRepository.getIssues(
          login: login, endCursor: state.issues.pageInfo.endCursor);
      yield LoadedIssuesState.next(
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

class LoadRepoIssuesEvent extends IssuesEvent {
  final String owner;
  final String name;
  final bool isLoadNextRepoIssues;

  LoadRepoIssuesEvent({this.owner,this.name, this.isLoadNextRepoIssues = false});
  @override
  Stream<IssuesState> loadRepoIssues(
      {IssuesState currentState, IssuesBloc bloc}) async* {
    try {
      if (currentState is LoadedIssuesState) {
        return;
      }
      yield LoadingRepoIssuesState();
      final issues = await _issuesRepository.getRepoIssues(name:name,owner:owner);
      yield LoadedRepoIssuesState(issues);
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'LoadRepoEvent', error: _, stackTrace: stackTrace);
      yield ErrorRepoIssuesState(_?.toString());
    }
  }

  Stream<IssuesState> getNextRepoIssues(
      {IssuesState currentState, IssuesBloc bloc}) async* {
    try {
      final state = currentState as LoadedRepoIssuesState;
      if (!state.issues.pageInfo.hasNextPage) {
        print("No repo issues left");
        return;
      }else if(currentState is LoadingNextRepoIssuessState){
        print("Wait for old state chanege");
        return;
      }
      
      yield LoadingNextRepoIssuessState(state.issues);
      final issuesModel = await _issuesRepository.getRepoIssues(owner:owner,name:name, endCursor: state.issues.pageInfo.endCursor);
      yield LoadedRepoIssuesState.next(
        currentIssueModel: state.issues,
        issuesModel: issuesModel,
      );
    } catch (_, stackTrace) {
      developer.log('$_',name: 'LoadNextRepoEvent', error: _, stackTrace: stackTrace);
      final state = currentState as LoadedIssuesState;
      yield ErrorNextRepoIssuessState(
          errorMessage: _?.toString(), issues: state.issues);
    }
  }
}