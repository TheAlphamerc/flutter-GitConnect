import 'dart:async';
import 'dart:developer' as developer;

import 'package:equatable/equatable.dart';
import 'package:flutter_github_connect/bloc/search/index.dart';
import 'package:flutter_github_connect/resources/gatway/api_gatway.dart';
import 'package:flutter_github_connect/resources/repository/repo_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

@immutable
abstract class SearchEvent extends Equatable {
  @override
  List<Object> get props => [];

  Stream<SearchState> searchQuery({SearchState currentState, SearchBloc bloc});
  final SearchRepository _repoRepository = SearchRepository(apiGatway: GetIt.instance<ApiGateway>());
}

class SearchForEvent extends SearchEvent {
  final GithubSearchType type;
  final String query;
  @override
  String toString() => 'LoadRepoEvent';

  SearchForEvent({this.query, this.type});

  @override
  Stream<SearchState> searchQuery(
      {SearchState currentState, SearchBloc bloc}) async* {
    try {
      assert(this.type != null, this.query != null);
      yield LoadingSearchState();
      final list = await _repoRepository.searchQuery(query: this.query,type:this.type);
      yield LoadedSearchState(list, type);
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'LoadRepoEvent', error: _, stackTrace: stackTrace);
      yield ErrorRepoState(0, _?.toString());
    }
  }
}
