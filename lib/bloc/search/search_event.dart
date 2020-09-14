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
  final SearchRepository _repoRepository =
      SearchRepository(apiGatway: GetIt.instance<ApiGateway>());
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
      String endCursor;
      if (currentState is LoadedSearchState) {
        endCursor = currentState.endCursor;
      }
      assert(this.type != null, this.query != null);
      if (!(currentState is LoadedSearchState)) {
        yield LoadingSearchState();
      } else if (currentState is LoadedSearchState) {
        if(currentState is LoadingNextSearchState){
          print("Restrict APi calling untill previus state is not updated");
          return;
        }
        yield LoadingNextSearchState(
            endCursor: currentState.endCursor,
            type: type,
            list: currentState.list,
            hasNextPage: currentState.hasNextPage);
        print("CAliing API to get data");
      }
      final search = await _repoRepository.searchQuery(
          query: this.query, type: this.type, endCursor: endCursor);
      // List<dynamic> list = [];
      if (currentState is LoadedSearchState) {
        // list.add(currentState.list);
        // list.addAll(search.list);
        yield LoadedSearchState.next(
            list: search.list,
            dynamicList: currentState.list,
            type: type,
            endCursor: search?.pageInfo?.endCursor,
            hasNextPage: search?.pageInfo?.hasNextPage);
      } else {
        yield LoadedSearchState(
            list: search.list,
            type: type,
            endCursor: search?.pageInfo?.endCursor,
            hasNextPage: search?.pageInfo?.hasNextPage);
      }
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'SearchForEvent', error: _, stackTrace: stackTrace);
      if (currentState is LoadedSearchState) {
        yield ErrorNextRepoState(_?.toString(),
            list: currentState.list,
            endCursor: currentState.endCursor,
            hasNextPage: currentState.hasNextPage,
            type: currentState.type);
      } else
        yield ErrorRepoState(_?.toString());
    }
  }
}
