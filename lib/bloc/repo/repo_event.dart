import 'dart:async';
import 'dart:developer' as developer;

import 'package:equatable/equatable.dart';
import 'package:flutter_github_connect/bloc/repo/index.dart';
import 'package:flutter_github_connect/resources/provider/api_gatway.dart';
import 'package:flutter_github_connect/resources/repository/repo_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

@immutable
abstract class RepoEvent extends Equatable {
  @override
  List<Object> get props => [];

  Stream<RepoState> getRepositoryAsync({RepoState currentState, RepoBloc bloc});
  final RepoRepository _repoRepository = RepoRepository(apiGatway: GetIt.instance<ApiGateway>());
}

class LoadRepoEvent extends RepoEvent {
  final bool isError;
  @override
  String toString() => 'LoadRepoEvent';

  LoadRepoEvent(this.isError);

  @override
  Stream<RepoState> getRepositoryAsync(
      {RepoState currentState, RepoBloc bloc}) async* {
    try {
      // yield LoadingUserState();
      // final list = await _repoRepository.fetchRepositories(isError);
      // yield LoadedRepositoriesState(list);
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'LoadRepoEvent', error: _, stackTrace: stackTrace);
      yield ErrorRepoState(0, _?.toString());
    }
  }
}
