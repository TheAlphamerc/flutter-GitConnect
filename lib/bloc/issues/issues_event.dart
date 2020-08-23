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

  LoadIssuesEvent(this.login);
  @override
  Stream<IssuesState> applyAsync(
      {IssuesState currentState, IssuesBloc bloc}) async* {
    try {
      if (currentState is LoadedIssuesState) {
        return;
      }
      yield LoadingUserState();
      final list = await _issuesRepository.getIssues(login:login);
      yield LoadedIssuesState(list);
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'LoadIssuesEvent', error: _, stackTrace: stackTrace);
      yield ErrorIssuesState(_?.toString());
    }
  }
}
